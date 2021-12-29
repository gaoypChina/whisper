// material
import 'package:flutter/material.dart';
// package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import 'package:whisper/constants/voids.dart' as voids;
import 'package:whisper/constants/routes.dart' as routes;
// components
import 'package:whisper/details/loading.dart';
import 'package:whisper/details/judge_screen.dart';
import 'package:whisper/posts/components/details/post_card.dart';
import 'package:whisper/components/user_show/components/details/post_cards.dart';
// model
import 'package:whisper/main_model.dart';
import 'package:whisper/components/user_show/user_show_model.dart';
import 'package:whisper/posts/components/comments/comments_model.dart';
import 'package:whisper/official_adsenses/official_adsenses_model.dart';
import 'package:whisper/posts/components/other_pages/post_show/components/edit_post_info/edit_post_info_model.dart';
class UserShowPostScreen extends ConsumerWidget {
  
  const UserShowPostScreen({
    Key? key,
    required this.userShowModel,
    required this.mainModel
  }) : super(key: key);

  final UserShowModel userShowModel;
  final MainModel mainModel;

  @override
  Widget build(BuildContext context,ScopedReader watch) {

    final editPostInfoModel = watch(editPostInfoProvider);
    final commentsModel = watch(commentsProvider);
    final officialAdsensesModel = watch(officialAdsensesProvider); 
    final isLoading = userShowModel.isLoading;
    final postDocs = userShowModel.userShowDocs;
    final Widget posts = Expanded(
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        controller: userShowModel.refreshController,
        onRefresh: () async {
          await userShowModel.onRefresh();
        },
        onLoading: () async {
          await userShowModel.onLoading();
        },
        child: ListView.builder(
          itemCount: postDocs.length,
          itemBuilder: (BuildContext context, int i) {
            final Map<String,dynamic> post = postDocs[i].data() as Map<String,dynamic>;
            return 
            PostCard(
              post: post,
              onDeleteButtonPressed: () { voids.onPostDeleteButtonPressed(context: context, audioPlayer: userShowModel.audioPlayer, postMap: postDocs[i].data() as Map<String,dynamic>, afterUris: userShowModel.afterUris, results: userShowModel.userShowDocs, mainModel: mainModel, i: i); },
              initAudioPlayer: () async {
                await userShowModel.initAudioPlayer(i);
              },
              muteUser: () async {
                await userShowModel.muteUser(mainModel.mutesUids,mainModel.prefs, i, mainModel.currentUserDoc,mainModel.mutesIpv6AndUids,post);
              },
              mutePost: () async {
                await userShowModel.mutePost(mainModel.mutesPostIds, mainModel.prefs, i,post);
              },
              blockUser: () async {
                await userShowModel.blockUser(mainModel.currentUserDoc, mainModel.blocksUids, i,mainModel.mutesIpv6AndUids,post);
              },
              mainModel: mainModel,
            );
          }
        ),
      ),
    );
    final content =  Padding(
      padding: EdgeInsets.only(top: 20),
      child: PostCards(
        postDocs: userShowModel.userShowDocs, 
        route: () {
          routes.toPostShowPage(
            context: context,
            speedNotifier: userShowModel.speedNotifier,
            speedControll:  () async { await voids.speedControll(audioPlayer: userShowModel.audioPlayer, prefs: mainModel.prefs,speedNotifier: userShowModel.speedNotifier); },
            currentSongMapNotifier: userShowModel.currentSongMapNotifier, 
            progressNotifier: userShowModel.progressNotifier, 
            seek: userShowModel.seek, 
            repeatButtonNotifier: userShowModel.repeatButtonNotifier, 
            onRepeatButtonPressed:  () { voids.onRepeatButtonPressed(audioPlayer: userShowModel.audioPlayer, repeatButtonNotifier: userShowModel.repeatButtonNotifier); }, 
            isFirstSongNotifier: userShowModel.isFirstSongNotifier, 
            onPreviousSongButtonPressed:  () { voids.onPreviousSongButtonPressed(audioPlayer: userShowModel.audioPlayer); }, 
            playButtonNotifier: userShowModel.playButtonNotifier, 
            play: () async { 
              await voids.play(context: context, audioPlayer: userShowModel.audioPlayer, mainModel: mainModel, postId: userShowModel.currentSongMapNotifier.value['postId'], officialAdsensesModel: officialAdsensesModel);
            }, 
            pause: () { voids.pause(audioPlayer: userShowModel.audioPlayer); }, 
            isLastSongNotifier: userShowModel.isLastSongNotifier, 
            onNextSongButtonPressed:  () { voids.onNextSongButtonPressed(audioPlayer: userShowModel.audioPlayer); },
            toCommentsPage:  () async {
              await commentsModel.init(context, userShowModel.audioPlayer, userShowModel.currentSongMapNotifier, mainModel, userShowModel.currentSongMapNotifier.value['postId']);
            },
            toEditingMode:  () {
              voids.toEditPostInfoMode(audioPlayer: userShowModel.audioPlayer, editPostInfoModel: editPostInfoModel);
            },
            mainModel: mainModel
          ); 
        }, 
        progressNotifier: userShowModel.progressNotifier,
        seek: userShowModel.seek,
        currentSongMapNotifier: userShowModel.currentSongMapNotifier,
        playButtonNotifier: userShowModel.playButtonNotifier,
        play: () async {
          await voids.play(context: context, audioPlayer: userShowModel.audioPlayer, mainModel: mainModel, postId: userShowModel.currentSongMapNotifier.value['postId'], officialAdsensesModel: officialAdsensesModel);
        },
        pause: () {
          voids.pause(audioPlayer: userShowModel.audioPlayer);
        }, 
        currentUserDoc: mainModel.currentUserDoc,
        refreshController: userShowModel.refreshController,
        onRefresh: () async { await userShowModel.onRefresh(); },
        onLoading: () async { await userShowModel.onLoading(); },
        isFirstSongNotifier: userShowModel.isFirstSongNotifier,
        onPreviousSongButtonPressed: () { voids.onPreviousSongButtonPressed(audioPlayer: userShowModel.audioPlayer); },
        isLastSongNotifier: userShowModel.isLastSongNotifier,
        onNextSongButtonPressed: () { voids.onNextSongButtonPressed(audioPlayer: userShowModel.audioPlayer); },
        mainModel: mainModel,
        posts: posts,
      ),
    );
    
    return isLoading ?
    Loading()
    : JudgeScreen(
      list: postDocs, 
      content: content,
      reload: () async {
        userShowModel.startLoading();
        await userShowModel.getPosts();
        userShowModel.endLoading();
      },
    );
    
  }
}