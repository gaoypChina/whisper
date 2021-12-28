// material
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// comopnents
import 'package:whisper/constants/voids.dart' as voids;
import 'package:whisper/constants/routes.dart' as routes;
import 'package:whisper/posts/components/other_pages/post_show/post_show_page.dart';
// model
import 'package:whisper/main_model.dart';
import 'package:whisper/posts/components/other_pages/post_show/components/edit_post_info/edit_post_info_model.dart';
import 'package:whisper/one_post/one_post_model.dart';

class OnePostPage extends ConsumerWidget {

  OnePostPage({
    Key? key,
    required this.mainModel
  }) : super(key: key);

  final MainModel mainModel;

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final OnePostModel onePostModel = watch(onePostProvider);
    final EditPostInfoModel editPostInfoModel = watch(editPostInfoProvider);

    return Scaffold(
      body: PostShowPage(
        speedNotifier: onePostModel.speedNotifier, 
        speedControll: () { onePostModel.speedControll(prefs: mainModel.prefs); },
        currentSongMapNotifier: onePostModel.currentSongMapNotifier, 
        progressNotifier: onePostModel.progressNotifier, 
        seek: onePostModel.seek, 
        repeatButtonNotifier: onePostModel.repeatButtonNotifier, 
        onRepeatButtonPressed: onePostModel.onRepeatButtonPressed, 
        isFirstSongNotifier: onePostModel.isFirstSongNotifier, 
        onPreviousSongButtonPressed: onePostModel.onPreviousSongButtonPressed, 
        playButtonNotifier: onePostModel.playButtonNotifier, 
        play: () { voids.play( audioPlayer: onePostModel.audioPlayer ,readPostIds: mainModel.readPostIds, readPosts: mainModel.readPosts, currentUserDoc: mainModel.currentUserDoc, postId: onePostModel.currentSongMapNotifier.value['postId'] ); },
        pause: () { voids.pause(audioPlayer: onePostModel.audioPlayer); },
        isLastSongNotifier: onePostModel.isLastSongNotifier, 
        onNextSongButtonPressed: onePostModel.onNextSongButtonPressed, 
        toCommentsPage: () {
          routes.toCommentsPage(context, onePostModel.audioPlayer, onePostModel.currentSongMapNotifier, mainModel);
        },
        toEditingMode: () { onePostModel.toEditPostInfoMode(editPostInfoModel: editPostInfoModel); },
        mainModel: mainModel
      ),
    );
  }
}