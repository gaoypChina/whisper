// material
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import 'package:whisper/constants/counts.dart';
// notifiers
import 'package:whisper/posts/notifiers/play_button_notifier.dart';
import 'package:whisper/posts/notifiers/progress_notifier.dart';
import 'package:whisper/posts/notifiers/repeat_button_notifier.dart';

final recommendersProvider = ChangeNotifierProvider(
  (ref) => RecommendersModel()
);
class RecommendersModel extends ChangeNotifier {

  // basic
  bool isLoading = false;
  // user
  User? currentUser;

  // notifiers
  final currentSongDocNotifier = ValueNotifier<DocumentSnapshot?>(null);

  List<DocumentSnapshot> currentSongDocs = [];
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);
  
  late AudioPlayer audioPlayer;
  final List<AudioSource> afterUris = [];
  // cloudFirestore
  List<String> recommenderPostIds = [];
  List<String> mutesUids = [];
  List<DocumentSnapshot> recommenderDocs = [];

  // refresh
  int refreshIndex = defaultRefreshIndex;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  RecommendersModel() {
    init();
  }

  void init() async {
    startLoading();
    audioPlayer = AudioPlayer();
    setCurrentUser();
    // await setMutes();
    await getRecommenders();
    listenForStates();
    endLoading();
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
  }
  
  Future onRefresh() async {
    audioPlayer = AudioPlayer();
    refreshIndex = defaultRefreshIndex;
    recommenderDocs = [];
    await getRecommenders();
    notifyListeners();
    refreshController.refreshCompleted();
  }

  Future onLoading() async {
    await getRecommenders();
    refreshController.loadComplete();
    notifyListeners();
  }

  Future getRecommenders() async {
    final now = DateTime.now();
    final range = now.subtract(Duration(days: 5));
    
    try {

      if (refreshIndex == defaultRefreshIndex) {
        QuerySnapshot<Map<String, dynamic>> snapshots =  await FirebaseFirestore.instance
        .collection('posts')
        .where('createdAt', isGreaterThanOrEqualTo: range)
        .orderBy('createdAt', descending: true)
        .orderBy('score', descending: true)
        .limit(oneTimeReadCount)
        .get();
        print(snapshots.docs.length.toString() + 'snapshots');
        snapshots.docs.forEach((DocumentSnapshot? doc) {
          recommenderDocs.add(doc!);
          Uri song = Uri.parse(doc['audioURL']);
          UriAudioSource source = AudioSource.uri(song, tag: doc);
          afterUris.add(source);
        });
        if (afterUris.isNotEmpty) {
          ConcatenatingAudioSource playlist = ConcatenatingAudioSource(children: afterUris);
          await audioPlayer.setAudioSource(playlist);
        }
      } else {
        QuerySnapshot<Map<String, dynamic>> snapshots =  await FirebaseFirestore.instance
        .collection('posts')
        // .where('uid',whereNotIn: mutesUids)
        .where('createdAt', isGreaterThanOrEqualTo: range)
        .orderBy('createdAt', descending: true)
        .orderBy('score', descending: true)
        .startAfterDocument(recommenderDocs[refreshIndex])
        .limit(oneTimeReadCount)
        .get();
        snapshots.docs.forEach((DocumentSnapshot doc) {
          recommenderDocs.add(doc);
          Uri song = Uri.parse(doc['audioURL']);
          UriAudioSource source = AudioSource.uri(song, tag: doc);
          afterUris.add(source);
        });
        if (afterUris.isNotEmpty) {
          ConcatenatingAudioSource playlist = ConcatenatingAudioSource(children: afterUris);
          await audioPlayer.setAudioSource(playlist,initialIndex: refreshIndex);
        }
      }
      refreshIndex += oneTimeReadCount;
      print(recommenderDocs.length.toString() + "!!!!!!!!!");
    } catch(e) {
      print(e.toString() + "!!!!!!!!!!!!!!!!!!!!!");
    }
    notifyListeners();
  }

  void play(List<dynamic> readPostIds,List<dynamic> readPosts,DocumentSnapshot currentUserDoc)  {
    audioPlayer.play();
    notifyListeners();
    audioPlayer.sequenceStateStream.listen((sequenceState) {
      final currentItem = sequenceState!.currentSource;
      final DocumentSnapshot? currentSongDoc = currentItem?.tag;
      final postId = currentSongDoc!['postId'];
      if (!readPostIds.contains(postId)) {
        final map = {
          'createdAt': Timestamp.now(),
          'postId': postId,
        };
        readPosts.add(map);
        FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserDoc.id)
        .update({
          'readPosts': readPosts,
        });
      }
    });
  }

  void pause() {
    audioPlayer.pause();
    notifyListeners();
  }

  void seek(Duration position) {
    audioPlayer.seek(position);
  }
  // showPage
  void onRepeatButtonPressed() {
    repeatButtonNotifier.nextState();
    switch (repeatButtonNotifier.value) {
      case RepeatState.off:
        audioPlayer.setLoopMode(LoopMode.off);
        break;
      case RepeatState.repeatSong:
        audioPlayer.setLoopMode(LoopMode.one);
        break;
      case RepeatState.repeatPlaylist:
        audioPlayer.setLoopMode(LoopMode.all);
    }
  }

  void onPreviousSongButtonPressed() {
    audioPlayer.seekToPrevious();
  }

  void onNextSongButtonPressed() {
    audioPlayer.seekToNext();
  }

  void listenForStates() {
    listenForChangesInPlayerState();
    listenForChangesInPlayerPosition();
    listenForChangesInBufferedPosition();
    listenForChangesInTotalDuration();
    listenForChangesInSequenceState();
  }

  void listenForChangesInPlayerState() {
    audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        audioPlayer.seek(Duration.zero);
        audioPlayer.pause();
      }
    });
  }

  void listenForChangesInPlayerPosition() {
    audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void listenForChangesInBufferedPosition() {
    audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void listenForChangesInTotalDuration() {
    audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void listenForChangesInSequenceState() {
    audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;
      // update current song doc
      final currentItem = sequenceState.currentSource;
      final DocumentSnapshot? currentSongDoc = currentItem?.tag;
      currentSongDocNotifier.value = currentSongDoc;
      // update playlist
      final playlist = sequenceState.effectiveSequence;
      playlist.map((item) {
        currentSongDocs.add(item.tag);
      });
      // update shuffle mode
      isShuffleModeEnabledNotifier.value = 
      sequenceState.shuffleModeEnabled;
      // update previous and next buttons
      if (playlist.isEmpty || currentItem == null) {
        isFirstSongNotifier.value = true;
        isLastSongNotifier.value = true; 
      } else {
        isFirstSongNotifier.value = playlist.first == currentItem;
        isLastSongNotifier.value = playlist.last == currentItem;
      }
    });
    notifyListeners();
  }
}