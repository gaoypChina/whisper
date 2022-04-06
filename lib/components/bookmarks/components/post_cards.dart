// material
import 'package:flutter/cupertino.dart';
// package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import 'package:whisper/constants/strings.dart';
// components
import 'package:whisper/details/positive_text.dart';
import 'package:whisper/posts/components/details/post_card.dart';
import 'package:whisper/posts/components/audio_window/audio_window.dart';
// domain
import 'package:whisper/domain/post/post.dart';
// notifiers
import 'package:whisper/posts/notifiers/progress_notifier.dart';
import 'package:whisper/posts/notifiers/play_button_notifier.dart';
// model
import 'package:whisper/main_model.dart';
import 'package:whisper/components/bookmarks/bookmarks_model.dart';
import 'package:whisper/posts/components/post_buttons/post_futures.dart';

class PostCards extends StatelessWidget {

  const PostCards({
    Key? key,
    required this.postDocs,
    required this.route,
    required this.progressNotifier,
    required this.seek,
    required this.currentWhisperPostNotifier,
    required this.playButtonNotifier,
    required this.play,
    required this.pause,
    required this.refreshController,
    required this.onLoading,
    required this.isFirstSongNotifier,
    required this.onPreviousSongButtonPressed,
    required this.isLastSongNotifier,
    required this.onNextSongButtonPressed,
    required this.mainModel,
    required this.bookmarksModel,
    required this.postFutures
  }) : super(key: key);

 
  final List<DocumentSnapshot> postDocs;
  final void Function()? route;
  final ProgressNotifier progressNotifier;
  final void Function(Duration)? seek;
  final ValueNotifier<Post?> currentWhisperPostNotifier;
  final PlayButtonNotifier playButtonNotifier;
  final void Function()? play;
  final void Function()? pause;
  // refresh
  final RefreshController refreshController;
  final void Function()? onLoading;
  final ValueNotifier<bool> isFirstSongNotifier;
  final void Function()? onPreviousSongButtonPressed;
  final ValueNotifier<bool> isLastSongNotifier;
  final void Function()? onNextSongButtonPressed;
  final MainModel mainModel;
  final BookmarksModel bookmarksModel;
  final PostFutures postFutures;

  @override 
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SmartRefresher(
            // enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            controller: refreshController,
            // onRefresh: onRefresh,
            onLoading: onLoading,
            child: ListView.builder(
              itemCount: postDocs.length,
              itemBuilder: (BuildContext context, int i) {
                final Map<String,dynamic> post = postDocs[i].data() as Map<String,dynamic>;
                final Post whisperPost = Post.fromJson(post);
                return 
                PostCard(
                  post: post,
                  onDeleteButtonPressed: () { postFutures.onPostDeleteButtonPressed(context: context, audioPlayer: bookmarksModel.audioPlayer, postMap: post, afterUris: bookmarksModel.afterUris, posts: bookmarksModel.posts, mainModel: mainModel, i: i); },
                  initAudioPlayer: () async => await postFutures.initAudioPlayer(audioPlayer: bookmarksModel.audioPlayer, afterUris: bookmarksModel.afterUris, i: i),
                  muteUser: () async => await postFutures.muteUser(context: context,audioPlayer: bookmarksModel.audioPlayer, afterUris: bookmarksModel.afterUris, muteUids: mainModel.muteUids, i: i, results: bookmarksModel.posts, muteUsers: mainModel.muteUsers, post: post, mainModel: mainModel),
                  mutePost: () async => await postFutures.mutePost(context: context,mainModel: mainModel, i: i, post: post, afterUris: bookmarksModel.afterUris, audioPlayer: bookmarksModel.audioPlayer, results: bookmarksModel.posts ),
                  reportPost: () => postFutures.reportPost(context: context, mainModel: mainModel, i: i, post: Post.fromJson(post), afterUris: bookmarksModel.afterUris, audioPlayer: bookmarksModel.audioPlayer, results: bookmarksModel.posts ),
                  reportPostButtonBuilder:  (innerContext) {
                    return CupertinoActionSheet(
                      actions: whisperPost.uid == mainModel.userMeta.uid ?
                      [  
                        CupertinoActionSheetAction(onPressed: () {
                          Navigator.pop(innerContext);
                          postFutures.onPostDeleteButtonPressed(context: context, audioPlayer: bookmarksModel.audioPlayer, postMap: post, afterUris: bookmarksModel.afterUris, posts: bookmarksModel.posts, mainModel: mainModel, i: i);
                        }, child: PositiveText(text: deletePostText) ),
                        CupertinoActionSheetAction(onPressed: () => Navigator.pop(innerContext), child: PositiveText(text: cancelText) ),
                      ]
                      : [
                        CupertinoActionSheetAction(onPressed: () async {
                          Navigator.pop(innerContext);
                          await postFutures.muteUser(context: context, audioPlayer: bookmarksModel.audioPlayer, afterUris: bookmarksModel.afterUris, muteUids: mainModel.muteUids, i: i, results: bookmarksModel.posts, muteUsers: mainModel.muteUsers, post: post, mainModel: mainModel);
                        }, child: PositiveText(text: muteUserJaText) ),
                        CupertinoActionSheetAction(onPressed: () async {
                          Navigator.pop(innerContext);
                          await postFutures.mutePost(context: context, mainModel: mainModel, i: i, post: post, afterUris: bookmarksModel.afterUris, audioPlayer: bookmarksModel.audioPlayer, results: bookmarksModel.posts);
                        }, child: PositiveText(text: mutePostJaText) ),
                        CupertinoActionSheetAction(onPressed: () {
                          Navigator.pop(innerContext);
                          postFutures.reportPost(context: context, mainModel: mainModel, i: i, post: whisperPost, afterUris: bookmarksModel.afterUris, audioPlayer: bookmarksModel.audioPlayer, results: bookmarksModel.posts);
                        }, child: PositiveText(text: reportPostJaText) ),
                        CupertinoActionSheetAction(onPressed: () => Navigator.pop(innerContext), child: PositiveText(text: cancelText) ),
                      ],
                    );
                  },
                  mainModel: mainModel,
                );
              }
            ),
          ),
        ),
        ValueListenableBuilder<Post?>(
          valueListenable: bookmarksModel.currentWhisperPostNotifier,
          builder: (_,whisperPost,__) {
            return AudioWindow(
              route: route, 
              progressNotifier: progressNotifier, 
              seek: seek, 
              whisperPost: whisperPost!,
              playButtonNotifier: playButtonNotifier, 
              play: play, 
              pause: pause, 
              isFirstSongNotifier: isFirstSongNotifier,
              onPreviousSongButtonPressed: onPreviousSongButtonPressed,
              isLastSongNotifier: isLastSongNotifier,
              onNextSongButtonPressed: onNextSongButtonPressed,
              mainModel: mainModel,
            );
          }
        )
      ],
    );
  }
}