// material
import 'package:flutter/material.dart';
// package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import 'package:whisper/constants/voids.dart' as voids;
// components
import 'package:whisper/posts/components/details/post_card.dart';
import 'package:whisper/posts/components/audio_window/audio_window.dart';
// notifiers
import 'package:whisper/posts/notifiers/progress_notifier.dart';
import 'package:whisper/posts/notifiers/play_button_notifier.dart';
// model
import 'package:whisper/main_model.dart';
import 'package:whisper/components/bookmarks/bookmarks_model.dart';

class PostCards extends StatelessWidget {

  const PostCards({
    Key? key,
    required this.postDocs,
    required this.route,
    required this.progressNotifier,
    required this.seek,
    required this.currentSongMapNotifier,
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
    required this.bookmarksModel
  }) : super(key: key);

 
  final List<DocumentSnapshot> postDocs;
  final void Function()? route;
  final ProgressNotifier progressNotifier;
  final void Function(Duration)? seek;
  final ValueNotifier<Map<String,dynamic>> currentSongMapNotifier;
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

  @override 
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            // enablePullUp: true,
            header: WaterDropHeader(),
            controller: refreshController,
            // onRefresh: onRefresh,
            onLoading: onLoading,
            child: ListView.builder(
              itemCount: postDocs.length,
              itemBuilder: (BuildContext context, int i) {
                final Map<String,dynamic> post = postDocs[i].data() as Map<String,dynamic>;
                return 
                PostCard(
                  post: post,
                  onDeleteButtonPressed: () { voids.onPostDeleteButtonPressed(context: context, audioPlayer: bookmarksModel.audioPlayer, postMap: postDocs[i].data() as Map<String,dynamic>, afterUris: bookmarksModel.afterUris, posts: bookmarksModel.posts, mainModel: mainModel, i: i); },
                  initAudioPlayer: () async {
                    await voids.initAudioPlayer(audioPlayer: bookmarksModel.audioPlayer, afterUris: bookmarksModel.afterUris, i: i);
                  },
                  muteUser: () async {
                    await voids.muteUser(audioPlayer: bookmarksModel.audioPlayer, afterUris: bookmarksModel.afterUris, mutesUids: mainModel.mutesUids, i: i, results: bookmarksModel.posts, mutesIpv6AndUids: mainModel.muteUsers, post: post, mainModel: mainModel);
                  },
                  mutePost: () async {
                    await voids.mutePost(mainModel: mainModel, i: i, post: post, afterUris: bookmarksModel.afterUris, audioPlayer: bookmarksModel.audioPlayer, results: bookmarksModel.posts );
                  },
                  blockUser: () async {
                    await voids.blockUser(audioPlayer: bookmarksModel.audioPlayer, afterUris: bookmarksModel.afterUris, blocksUids: mainModel.blocksUids, blocksIpv6AndUids: mainModel.blockUsers, i: i, results: bookmarksModel.posts, post: post, mainModel: mainModel);
                  },
                  mainModel: mainModel,
                );
              }
            ),
          ),
        ),
        AudioWindow(
          route: route, 
          progressNotifier: progressNotifier, 
          seek: seek, 
          currentSongMapNotifier: currentSongMapNotifier, 
          playButtonNotifier: playButtonNotifier, 
          play: play, 
          pause: pause, 
          isFirstSongNotifier: isFirstSongNotifier,
          onPreviousSongButtonPressed: onPreviousSongButtonPressed,
          isLastSongNotifier: isLastSongNotifier,
          onNextSongButtonPressed: onNextSongButtonPressed,
          mainModel: mainModel,
        )
      ],
    );
  }
}