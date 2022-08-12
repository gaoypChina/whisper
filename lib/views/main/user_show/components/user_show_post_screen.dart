// material
import 'package:flutter/cupertino.dart';
// package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/constants/doubles.dart';
// constants
import 'package:whisper/constants/strings.dart';
import 'package:whisper/constants/voids.dart' as voids;
import 'package:whisper/constants/routes.dart' as routes;
// components
import 'package:whisper/details/positive_text.dart';
import 'package:whisper/details/refresh_screen.dart';
import 'package:whisper/posts/components/details/post_card.dart';
import 'package:whisper/views/main/user_show/components/post_cards.dart';
import 'package:whisper/posts/components/comments_or_replys/comments_or_replys_model.dart';
// domain
import 'package:whisper/domain/post/post.dart';
// model
import 'package:whisper/main_model.dart';
import 'package:whisper/models/main/user_show_model.dart';
import 'package:whisper/models/comments/comments_model.dart';
import 'package:whisper/models/posts/posts_model.dart';
import 'package:whisper/models/edit_post_info/edit_post_info_model.dart';
class UserShowPostScreen extends ConsumerWidget {
  
  const UserShowPostScreen({
    Key? key,
    required this.userShowModel,
    required this.mainModel
  }) : super(key: key);

  final UserShowModel userShowModel;
  final MainModel mainModel;

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final EditPostInfoModel editPostInfoModel = ref.watch(editPostInfoProvider);
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final PostsModel postFutures = ref.watch(postsFeaturesProvider);
    final CommentsOrReplysModel commentsOrReplysModel = ref.watch(commentsOrReplysProvider);

    final postDocs = userShowModel.posts;
    
    return Padding(
      padding: EdgeInsets.only(top: defaultPadding(context: context) ),
      child: PostCards(
        route: () {
          routes.toPostShowPage(
            context: context,
            speedNotifier: userShowModel.speedNotifier,
            speedControll:  () async => await voids.speedControll(audioPlayer: userShowModel.audioPlayer, prefs: mainModel.prefs,speedNotifier: userShowModel.speedNotifier),
            currentWhisperPostNotifier: userShowModel.currentWhisperPostNotifier, 
            progressNotifier: userShowModel.progressNotifier, 
            seek: userShowModel.seek, 
            repeatButtonNotifier: userShowModel.repeatButtonNotifier, 
            onRepeatButtonPressed:  () => voids.onRepeatButtonPressed(audioPlayer: userShowModel.audioPlayer, repeatButtonNotifier: userShowModel.repeatButtonNotifier),
            isFirstSongNotifier: userShowModel.isFirstSongNotifier, 
            onPreviousSongButtonPressed:  () => voids.onPreviousSongButtonPressed(audioPlayer: userShowModel.audioPlayer),
            playButtonNotifier: userShowModel.playButtonNotifier, 
            play: () => voids.play(audioPlayer: userShowModel.audioPlayer),
            pause: () => voids.pause(audioPlayer: userShowModel.audioPlayer),
            isLastSongNotifier: userShowModel.isLastSongNotifier, 
            onNextSongButtonPressed:  () => voids.onNextSongButtonPressed(audioPlayer: userShowModel.audioPlayer),
            toCommentsPage:  () async => await commentsModel.init(context: context, audioPlayer: userShowModel.audioPlayer, whisperPostNotifier: userShowModel.currentWhisperPostNotifier, mainModel: mainModel, whisperPost: userShowModel.currentWhisperPostNotifier.value!,commentsOrReplysModel: commentsOrReplysModel ),
            toEditingMode:  () => voids.toEditPostInfoMode(audioPlayer: userShowModel.audioPlayer, editPostInfoModel: editPostInfoModel),
            postType: userShowModel.postType,
            mainModel: mainModel
          ); 
        }, 
        progressNotifier: userShowModel.progressNotifier,
        seek: userShowModel.seek,
        currentWhisperPostNotifier: userShowModel.currentWhisperPostNotifier,
        playButtonNotifier: userShowModel.playButtonNotifier,
        play: () => voids.play(audioPlayer: userShowModel.audioPlayer),
        pause: () => voids.pause(audioPlayer: userShowModel.audioPlayer),
        isFirstSongNotifier: userShowModel.isFirstSongNotifier,
        onPreviousSongButtonPressed: () => voids.onPreviousSongButtonPressed(audioPlayer: userShowModel.audioPlayer),
        isLastSongNotifier: userShowModel.isLastSongNotifier,
        onNextSongButtonPressed: () => voids.onNextSongButtonPressed(audioPlayer: userShowModel.audioPlayer),
        mainModel: mainModel,
        posts: RefreshScreen(
          isEmpty: userShowModel.posts.isEmpty,
          subWidget: SizedBox.shrink(),
          controller: userShowModel.refreshController,
          onRefresh: () async => await userShowModel.onRefresh(),
          onReload: () async => await userShowModel.onReload(),
          onLoading: () async => await userShowModel.onLoading(),
          child: ListView.builder(
            itemCount: postDocs.length,
            itemBuilder: (BuildContext context, int i) {
              final postDoc = postDocs[i];
              final Post whisperPost = Post.fromJson(postDoc.data()!);
              return 
              PostCard(
                postDoc: postDoc,
                onDeleteButtonPressed: () { postFutures.onPostDeleteButtonPressed(context: context, audioPlayer: userShowModel.audioPlayer, whisperPost: whisperPost, afterUris: userShowModel.afterUris, posts: userShowModel.posts, mainModel: mainModel, i: i); },
                initAudioPlayer: () async => await postFutures.initAudioPlayer(audioPlayer: userShowModel.audioPlayer, afterUris: userShowModel.afterUris, i: i),
                muteUser: () async => await postFutures.muteUser(context: context,audioPlayer: userShowModel.audioPlayer, afterUris: userShowModel.afterUris, muteUids: mainModel.muteUids, i: i, results: userShowModel.posts, muteUsers: mainModel.muteUsers, whisperPost:whisperPost, mainModel: mainModel),
                mutePost: () async => await postFutures.mutePost(context: context,mainModel: mainModel, i: i, postDoc: postDoc, afterUris: userShowModel.afterUris, audioPlayer: userShowModel.audioPlayer, results: userShowModel.posts ),
                reportPost: () => postFutures.reportPost(context: context, mainModel: mainModel, i: i, post: whisperPost, afterUris: userShowModel.afterUris, audioPlayer: userShowModel.audioPlayer, results: userShowModel.posts ),
                reportPostButtonBuilder:  (innerContext) {
                  return CupertinoActionSheet(
                    actions: whisperPost.uid == mainModel.userMeta.uid ?
                    [  
                      CupertinoActionSheetAction(onPressed: () {
                        Navigator.pop(innerContext);
                        postFutures.onPostDeleteButtonPressed(context: context, audioPlayer: userShowModel.audioPlayer, whisperPost: whisperPost, afterUris: userShowModel.afterUris, posts: userShowModel.posts, mainModel: mainModel, i: i);
                      }, child: PositiveText(text: deletePostText(context: context)) ),
                      CupertinoActionSheetAction(onPressed: () => Navigator.pop(innerContext), child: PositiveText(text: cancelText(context: context)) ),
                    ]
                    : [
                      CupertinoActionSheetAction(onPressed: () async {
                        Navigator.pop(innerContext);
                        await postFutures.muteUser(context: context, audioPlayer: userShowModel.audioPlayer, afterUris: userShowModel.afterUris, muteUids: mainModel.muteUids, i: i, results: userShowModel.posts, muteUsers: mainModel.muteUsers, whisperPost:whisperPost, mainModel: mainModel);
                      }, child: PositiveText(text: muteUserText(context: context)) ),
                      CupertinoActionSheetAction(onPressed: () async {
                        Navigator.pop(innerContext);
                        await postFutures.mutePost(context: context, mainModel: mainModel, i: i, postDoc: postDoc,afterUris: userShowModel.afterUris, audioPlayer: userShowModel.audioPlayer, results: userShowModel.posts);
                      }, child: PositiveText(text: mutePostText(context: context)) ),
                      CupertinoActionSheetAction(onPressed: () {
                        Navigator.pop(innerContext);
                        postFutures.reportPost(context: context, mainModel: mainModel, i: i, post: whisperPost, afterUris: userShowModel.afterUris, audioPlayer: userShowModel.audioPlayer, results: userShowModel.posts);
                      }, child: PositiveText(text: reportPostText(context: context)) ),
                      CupertinoActionSheetAction(onPressed: () => Navigator.pop(innerContext), child: PositiveText(text: cancelText(context: context)) ),
                    ],
                  );
                },
                mainModel: mainModel,
              );
            }
          ),
        )
      ),
    );
  }
}