// material
import 'package:flutter/material.dart';
// packages
import 'package:just_audio/just_audio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// constants
import 'package:whisper/constants/enums.dart';
import 'package:whisper/constants/ints.dart';
import 'package:whisper/constants/strings.dart';
import 'package:whisper/constants/others.dart';
import 'package:whisper/constants/voids.dart' as voids;
// domain
import 'package:whisper/domain/bookmark_post/bookmark_post.dart';
import 'package:whisper/domain/following/following.dart';
import 'package:whisper/domain/likeComment/like_comment.dart';
import 'package:whisper/domain/likeReply/like_reply.dart';
import 'package:whisper/domain/like_post/like_post.dart';
import 'package:whisper/domain/mute_comment/mute_comment.dart';
import 'package:whisper/domain/mute_post/mute_post.dart';
import 'package:whisper/domain/mute_reply/mute_reply.dart';
import 'package:whisper/domain/read_post/read_post.dart';
import 'package:whisper/domain/search_history/search_history.dart';
import 'package:whisper/domain/user_meta/user_meta.dart';
import 'package:whisper/domain/mute_user/mute_user.dart';
import 'package:whisper/domain/block_user/block_user.dart';
import 'package:whisper/domain/watchlist/watchlist.dart';
import 'package:whisper/domain/whisper_user/whisper_user.dart';
import 'package:whisper/domain/bookmark_label/bookmark_label.dart';
import 'package:whisper/domain/timeline/timeline.dart';
// notifiers
import 'package:whisper/posts/notifiers/play_button_notifier.dart';
import 'package:whisper/posts/notifiers/progress_notifier.dart';
import 'package:whisper/posts/notifiers/repeat_button_notifier.dart';

final mainProvider = ChangeNotifierProvider(
  (ref) => MainModel()
);

class MainModel extends ChangeNotifier {

  // basic
  bool isLoading = false;
  late SharedPreferences prefs;
  // user
  User? currentUser;
  late DocumentSnapshot<Map<String,dynamic>> currentUserDoc;
  late UserMeta userMeta;
  late WhisperUser currentWhisperUser;
  // tokens
  List<LikePost> likePosts = [];
  List<String> likePostIds = [];
  List<String> bookmarksPostIds = [];
  List<String> followingUids = [];
  List<LikeComment> likeComments = [];
  List<String> likeCommentIds = [];
  List<LikeReply> likeReplys = [];
  List<String> likeReplyIds = [];
  // bookmark
  List<BookmarkPost> bookmarkPosts = [];
  List<BookmarkLabel> bookmarkLabels = [];
  List<ReadPost> readPosts = [];
  List<String> readPostIds = [];
  // mutes 
  List<MuteUser> muteUsers = [];
  List<String> muteUids = [];
  List<String> muteIpv6s = [];
  List<MuteReply> muteReplys = [];
  List<String> muteReplyIds = [];
  List<MuteComment> muteComments = [];
  List<String> muteCommentIds = [];
  List<MutePost> mutePosts = [];
  List<String> mutePostIds = [];
  // block
  List<BlockUser> blockUsers = [];
  List<String> blockUids = [];
  List<String> blockIpv6s = [];
  // searchHistory
  List<SearchHistory> searchHistory = [];
  // watchlist 
  List<Watchlist> watchlists = [];
  // following
  List<Following> following = [];
  // bookmarkLabel
  String bookmarkLabelId = '';
  // feeds
  bool isFeedLoading = false;
  Query<Map<String,dynamic>> getQuery({ required QuerySnapshot<Map<String,dynamic>> timelinesQshot })  {
    final List<String> max10 = timelinesQshot.docs.map((e) => Timeline.fromJson(e.data()).postId ).toList();
    return returnPostsColGroupQuery.where(postIdFieldKey,whereIn: max10);
  }
  // notifiers
  final currentSongMapNotifier = ValueNotifier<Map<String,dynamic>>({});
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);
  // just_audio
  late AudioPlayer audioPlayer;
  List<AudioSource> afterUris = [];
  List<DocumentSnapshot<Map<String,dynamic>>> posts = [];
  List<DocumentSnapshot<Map<String,dynamic>>> timelineDocs = [];
  // refresh
  RefreshController refreshController = RefreshController(initialRefresh: false);
  // speed
  final speedNotifier = ValueNotifier<double>(1.0);
  // enum
  final PostType postType = PostType.feeds;

  MainModel() {
    init();
  }
  
  Future<void> init() async {
    startLoading();
    prefs = await SharedPreferences.getInstance();
    await setCurrentUser();
    final tokensQshot = await returnTokensColRef(uid: userMeta.uid).get();
    // if (tokensQshot.docs.isNotEmpty) {
    //   distributeTokens(tokensQshot: tokensQshot);
    // }
    print(tokensQshot.docs.length.toString() + "LENGTH!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    await getFeeds(followingUids: followingUids);
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

  void reload() {
    notifyListeners();
  }

  Future<void> setCurrentUser() async {
    currentUser = FirebaseAuth.instance.currentUser;
    currentUserDoc = await FirebaseFirestore.instance.collection(usersFieldKey).doc(currentUser!.uid).get();
    currentWhisperUser = WhisperUser.fromJson(currentUserDoc.data()!);
    final userMetaDoc = await FirebaseFirestore.instance.collection(userMetaFieldKey).doc(currentUser!.uid).get();
    userMeta = UserMeta.fromJson(userMetaDoc.data()!);
  }

  void distributeTokens({ required QuerySnapshot<Map<String, dynamic>> tokensQshot }) {
    tokensQshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> tokenDoc) {
      final Map<String,dynamic> tokenMap = tokenDoc.data()!;
      final TokenType tokenType = jsonToTokenType(tokenMap: tokenMap);
      switch(tokenType) {
        case TokenType.blockUser:
          final BlockUser blockUser = BlockUser.fromJson(tokenMap);
          blockUsers.add(blockUser);
        break;
        case TokenType.bookmarkLabel:
          final BookmarkLabel bookmarkLabel = BookmarkLabel.fromJson(tokenMap);
          bookmarkLabels.add(bookmarkLabel);
        break;
        case TokenType.bookmarkPost:
          final BookmarkPost bookmarkPost = BookmarkPost.fromJson(tokenMap);
          bookmarkPosts.add(bookmarkPost);
          bookmarksPostIds.add(bookmarkPost.postId);
        break;
        case TokenType.following:
          final Following followingInstantce = Following.fromJson(tokenMap);
          following.add(followingInstantce);
        break;
        case TokenType.likeComment:
          final LikeComment likeComment = LikeComment.fromJson(tokenMap);
          likeComments.add(likeComment);
        break;
        case TokenType.likePost:
          final LikePost likePost = LikePost.fromJson(tokenMap);
          likePosts.add(likePost);
        break;
        case TokenType.likeReply:
          final LikeReply likeReply = LikeReply.fromJson(tokenMap);
          likeReplys.add(likeReply);
        break;
        case TokenType.muteComment:
          final MuteComment muteComment = MuteComment.fromJson(tokenMap);
          muteComments.add(muteComment);
        break;
        case TokenType.mutePost:
          final MutePost mutePost = MutePost.fromJson(tokenMap);
          mutePosts.add(mutePost);
        break;
        case TokenType.muteReply:
          final MuteReply muteReply = MuteReply.fromJson(tokenMap);
          muteReplys.add(muteReply);
        break;
        case TokenType.muteUser:
          final MuteUser muteUser = MuteUser.fromJson(tokenMap);
          muteUsers.add(muteUser);
        break;
        case TokenType.readPost:
          final ReadPost readPost = ReadPost.fromJson(tokenMap);
          readPosts.add(readPost);
        break;
        case TokenType.searchHistory:
          final SearchHistory searchHistoryInstance = SearchHistory.fromJson(tokenMap);
          searchHistory.add(searchHistoryInstance);
        break;
        case TokenType.watchlist:
          final Watchlist watchlist = Watchlist.fromJson(tokenMap);
          watchlists.add(watchlist);
        break;
      }
    });
  }
  // feeds

  void startFeedLoading() {
    isFeedLoading = true;
    notifyListeners();
  }

  void endFeedLoading() {
    isFeedLoading = false;
    notifyListeners();
  }

  void seek(Duration position) {
    audioPlayer.seek(position);
  }

  Future<void> onRefresh({ required List<String> followingUids }) async {
    await getNewFeeds(followingUids: followingUids);
    refreshController.refreshCompleted();
    notifyListeners();
  }

  Future<void> onReload({ required List<String> followingUids }) async {
    startFeedLoading();
    await getFeeds(followingUids: followingUids);
    endFeedLoading();
  }

  Future<void> onLoading({ required List<String> followingUids }) async {
    await getOldFeeds(followingUids: followingUids);
    refreshController.loadComplete();
    notifyListeners();
  }

  Future<void> getNewFeeds({ required List<String> followingUids }) async {
    final timelinesQshot = await FirebaseFirestore.instance.collection(userMetaFieldKey).doc(firebaseAuthCurrentUser!.uid).collection(timelinesFieldKey).orderBy(createdAtFieldKey,descending: true).endBeforeDocument(timelineDocs.first).limit(tenCount).get();
    timelinesQshot.docs.reversed.forEach((element) { timelineDocs.insert(0, element); });
    if (followingUids.isNotEmpty && timelineDocs.isNotEmpty) {
      await voids.processNewPosts(query: getQuery(timelinesQshot: timelinesQshot), posts: posts, afterUris: afterUris, audioPlayer: audioPlayer, postType: postType, mutesUids: muteUids, blocksUids: blockUids, mutesIpv6s: muteIpv6s, blocksIpv6s: blockIpv6s, mutesPostIds: mutePostIds);
    }
  }

  // getFeeds
  Future<void> getFeeds({ required List<String> followingUids }) async {
    final timelinesQshot = await FirebaseFirestore.instance.collection(userMetaFieldKey).doc(firebaseAuthCurrentUser!.uid).collection(timelinesFieldKey).orderBy(createdAtFieldKey,descending: true).limit(tenCount).get();
    timelineDocs = timelinesQshot.docs;
    if (followingUids.isNotEmpty && timelineDocs.isNotEmpty) {
      await voids.processBasicPosts(query: getQuery(timelinesQshot: timelinesQshot), posts: posts, afterUris: afterUris, audioPlayer: audioPlayer, postType: postType, mutesUids: muteUids, blocksUids: blockUids, mutesIpv6s: muteIpv6s, blocksIpv6s: blockIpv6s, mutesPostIds: mutePostIds);
    }
  }

  Future<void> getOldFeeds({ required List<String> followingUids }) async {
    final timelinesQshot = await FirebaseFirestore.instance.collection(userMetaFieldKey).doc(firebaseAuthCurrentUser!.uid).collection(timelinesFieldKey).orderBy(createdAtFieldKey,descending: true).startAfterDocument(timelineDocs.last).limit(tenCount).get();
    timelinesQshot.docs.forEach((element) { timelineDocs.add(element); });
    if (followingUids.isNotEmpty && timelineDocs.isNotEmpty) {
      voids.processOldPosts(query: getQuery(timelinesQshot: timelinesQshot), posts: posts, afterUris: afterUris, audioPlayer: audioPlayer, postType: postType, mutesUids: muteUids, blocksUids: blockUids, mutesIpv6s: muteIpv6s, blocksIpv6s: blockIpv6s, mutesPostIds: mutePostIds);
    }
  }

}