// material
import 'package:flutter/material.dart';
// packages
import 'package:just_audio/just_audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:whisper/constants/voids.dart' as voids;
// notifiers
import 'package:whisper/posts/notifiers/play_button_notifier.dart';
import 'package:whisper/posts/notifiers/progress_notifier.dart';
import 'package:whisper/posts/notifiers/repeat_button_notifier.dart';

final onePostProvider = ChangeNotifierProvider(
  (ref) => OnePostModel()
);

class OnePostModel extends ChangeNotifier {
  
  // basic
  bool isLoading = false;
  // notifiers
  late AudioPlayer audioPlayer;
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);
  final speedNotifier = ValueNotifier<double>(1.0);
  // just_audio
  List<AudioSource> afterUris = [];
  // post
  late DocumentSnapshot<Map<String,dynamic>> onePostDoc;
  List<DocumentSnapshot<Map<String,dynamic>>> onePostDocList = [];
  final currentSongMapNotifier = ValueNotifier<Map<String,dynamic>>({});
  String postId = '';
  Future<bool> init({ required String givePostId}) async {
    startLoading();
    if (postId != givePostId) {
      onePostDocList = [];
      postId = givePostId;
      onePostDoc = await FirebaseFirestore.instance.collection('posts').doc(postId).get();
      onePostDocList.add(onePostDoc);
      currentSongMapNotifier.value = onePostDoc.data()!;
      Uri song = Uri.parse(onePostDoc['audioURL']);
      UriAudioSource audioSource = AudioSource.uri(song,tag: onePostDoc);
      audioPlayer = AudioPlayer();
      await audioPlayer.setAudioSource(audioSource);
      voids.listenForStates(audioPlayer: audioPlayer, playButtonNotifier: playButtonNotifier, progressNotifier: progressNotifier, currentSongMapNotifier: currentSongMapNotifier, isShuffleModeEnabledNotifier: isShuffleModeEnabledNotifier, isFirstSongNotifier: isFirstSongNotifier, isLastSongNotifier: isLastSongNotifier);
    }
    endLoading();
    return onePostDoc.exists;
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void seek(Duration position) {
    audioPlayer.seek(position);
  }

  
}