// material
import 'package:flutter/material.dart';
// package
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:whisper/constants/voids.dart' as voids;
import 'package:whisper/constants/routes.dart' as routes;
// components
import 'package:whisper/details/loading.dart';
import 'package:whisper/views/main/home/recommenders/components/post_cards.dart';
import 'package:whisper/posts/components/comments_or_replys/comments_or_replys_model.dart';
// model
import '../../../../models/main/recommenders_model.dart';
import 'package:whisper/main_model.dart';
import 'package:whisper/models/comments/comments_model.dart';
import 'package:whisper/models/posts/posts_model.dart';
import 'package:whisper/models/edit_post_info/edit_post_info_model.dart';

class RecommendersPage extends ConsumerWidget {
  
  const RecommendersPage({
    Key? key,
    required this.mainModel,
  }) : super(key: key);
  
  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RecommendersModel recommendersModel = ref.watch(recommendersProvider);
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final EditPostInfoModel editPostInfoModel = ref.watch(editPostInfoProvider);
    final CommentsOrReplysModel commentsOrReplysModel = ref.watch(commentsOrReplysProvider);
    final PostsModel postFutures = ref.watch(postsFeaturesProvider);

    return recommendersModel.isLoading ?
    Loading()
    : PostCards(
      postDocs: recommendersModel.posts, 
      postFutures: postFutures,
      route: () {
        routes.toPostShowPage(
          context: context,
          speedNotifier: recommendersModel.speedNotifier,
          speedControll:  () async => await voids.speedControll(audioPlayer: recommendersModel.audioPlayer, prefs: mainModel.prefs,speedNotifier: recommendersModel.speedNotifier),
          currentWhisperPostNotifier: recommendersModel.currentWhisperPostNotifier, 
          progressNotifier: recommendersModel.progressNotifier, 
          seek: recommendersModel.seek, 
          repeatButtonNotifier: recommendersModel.repeatButtonNotifier, 
          onRepeatButtonPressed:  () => voids.onRepeatButtonPressed(audioPlayer: recommendersModel.audioPlayer, repeatButtonNotifier: recommendersModel.repeatButtonNotifier),
          isFirstSongNotifier: recommendersModel.isFirstSongNotifier, 
          onPreviousSongButtonPressed:  () => voids.onPreviousSongButtonPressed(audioPlayer: recommendersModel.audioPlayer),
          playButtonNotifier: recommendersModel.playButtonNotifier, 
          play: () => voids.play(audioPlayer: recommendersModel.audioPlayer),
          pause: () => voids.pause(audioPlayer: recommendersModel.audioPlayer),
          isLastSongNotifier: recommendersModel.isLastSongNotifier, 
          onNextSongButtonPressed:  () => voids.onNextSongButtonPressed(audioPlayer: recommendersModel.audioPlayer),
          toCommentsPage:  () async => await commentsModel.init(context: context, audioPlayer: recommendersModel.audioPlayer, whisperPostNotifier: recommendersModel.currentWhisperPostNotifier, mainModel: mainModel, whisperPost: recommendersModel.currentWhisperPostNotifier.value!,commentsOrReplysModel: commentsOrReplysModel ),
          toEditingMode:  () => voids.toEditPostInfoMode(audioPlayer: recommendersModel.audioPlayer, editPostInfoModel: editPostInfoModel),
          postType: recommendersModel.postType,
          mainModel: mainModel
        ); 
      }, 
      progressNotifier: recommendersModel.progressNotifier,
      seek: recommendersModel.seek,
      currentWhisperPostNotifier: recommendersModel.currentWhisperPostNotifier,
      playButtonNotifier: recommendersModel.playButtonNotifier,
      play: () => voids.play(audioPlayer: recommendersModel.audioPlayer),
      pause: () => voids.pause(audioPlayer: recommendersModel.audioPlayer),
      refreshController: recommendersModel.refreshController,
      onRefresh: () async => await recommendersModel.onRefresh(),
      onReload: () async => await recommendersModel.onReload(),
      onLoading: () async => await recommendersModel.onLoading(),
      isFirstSongNotifier: recommendersModel.isFirstSongNotifier,
      onPreviousSongButtonPressed: () => voids.onPreviousSongButtonPressed(audioPlayer: recommendersModel.audioPlayer),
      isLastSongNotifier: recommendersModel.isLastSongNotifier,
      onNextSongButtonPressed: () => voids.onNextSongButtonPressed(audioPlayer: recommendersModel.audioPlayer),
      mainModel: mainModel,
      recommendersModel: recommendersModel,
    );
  }
}

