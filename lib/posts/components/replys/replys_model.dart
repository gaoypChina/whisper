// material
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// packages
import 'package:flash/flash.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import 'package:whisper/constants/bools.dart';
import 'package:whisper/constants/ints.dart';
import 'package:whisper/constants/others.dart';
import 'package:whisper/constants/doubles.dart';
import 'package:whisper/constants/strings.dart';
import 'package:whisper/constants/voids.dart' as voids;
import 'package:whisper/constants/routes.dart' as routes;
// states
import 'package:whisper/constants/enums.dart';
// model
import 'package:whisper/main_model.dart';

final replysProvider = ChangeNotifierProvider(
  (ref) => ReplysModel()
);

class ReplysModel extends ChangeNotifier {

  String reply = "";
  String elementState = commentKey;
  bool isLoading = false;
  Map<String,dynamic> giveComment = {};
  // snapshots
  int limitIndex = oneTimeReadCount;
  late Stream<QuerySnapshot> replysStream;
  // IP
  String ipv6 = '';
  // refresh
  SortState sortState = SortState.byNewestFirst;
  late RefreshController refreshController;
  // indexDB
  String indexCommentId = '';
  void reload() {
    notifyListeners();
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void onAddReplyButtonPressed({ required BuildContext context, required  Map<String,dynamic> currentSongMap, required TextEditingController replyEditingController, required  Map<String,dynamic> thisComment, required MainModel mainModel }) {
    // コメントの投稿主が自分の場合
    // このPostの投稿主が自分の場合
    // このPostの投稿主とコメントの投稿主が一致している場合
    final currentWhisperUser = mainModel.currentWhisperUser;
    final whisperComment = fromMapToWhisperComment(commentMap: thisComment);
    final whisperPost = fromMapToPost(postMap: currentSongMap);
    if (whisperComment.uid == currentWhisperUser.uid || whisperPost.uid == currentWhisperUser.uid || whisperComment.uid == whisperPost.uid) {
      showMakeReplyInputFlashBar(context: context, currentSongMap: currentSongMap, replyEditingController: replyEditingController, mainModel: mainModel, thisComment: thisComment);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('あなたはこのコメントに返信できません')));
    }
  }

  void showMakeReplyInputFlashBar({ required BuildContext context, required Map<String,dynamic> currentSongMap, required TextEditingController replyEditingController,required MainModel mainModel , required Map<String,dynamic> thisComment}) {
    final Widget Function(BuildContext, FlashController<Object?>, void Function(void Function()))? send = (context, controller, _) {
      return IconButton(
        onPressed: () async {
          if (reply.isEmpty) {
            controller.dismiss();
          } else {
            await makeReply(currentSongMap: currentSongMap, mainModel: mainModel, thisComment: thisComment);
            reply = '';
            replyEditingController.text = '';
            controller.dismiss();
          }
        },
        icon: Icon(Icons.send, color: Theme.of(context).primaryColor ),
      );
    };
    final void Function()? oncloseButtonPressed = () {
      reply = '';
      replyEditingController.text = '';
    };
    voids.showCommentOrReplyDialogue(context: context, title: 'リプライを入力', textEditingController: replyEditingController, onChanged: (text) { reply = text; }, oncloseButtonPressed: oncloseButtonPressed,send: send);
  }

  void showSortDialogue(BuildContext context,Map<String,dynamic> thisComment) {
    final whisperComment = fromMapToWhisperComment(commentMap: thisComment);
    showCupertinoDialog(
      context: context, 
      builder: (context) {
        return CupertinoActionSheet(
          title: Text('並び替え',style: TextStyle(fontWeight: FontWeight.bold)),
          message: Text('リプライを並び替えます',style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                replysStream = FirebaseFirestore.instance
                .collection(replysKey)
                .where(elementIdKey,isEqualTo: whisperComment.commentId )
                .orderBy(likeCountKey,descending: true )
                .limit(limitIndex)
                .snapshots();
                notifyListeners();
              }, 
              child: Text(
                'いいね順',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).highlightColor,
                ) 
              )
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                sortState = SortState.byNewestFirst;
                replysStream = FirebaseFirestore.instance
                .collection(replysKey)
                .where(elementIdKey,isEqualTo: whisperComment.commentId )
                .orderBy(createdAtKey,descending: true)
                .limit(limitIndex)
                .snapshots();
                notifyListeners();
              }, 
              child: Text(
                '新しい順',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).highlightColor,
                ) 
              )
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                sortState = SortState.byOldestFirst;
                replysStream = FirebaseFirestore.instance
                .collection(replysKey)
                .where(elementIdKey,isEqualTo: whisperComment.commentId )
                .orderBy(createdAtKey,descending: false)
                .limit(limitIndex)
                .snapshots();
                notifyListeners();
              }, 
              child: Text(
                '古い順',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).highlightColor,
                ) 
              )
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text(
                'キャンセル',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).highlightColor,
                ) 
              )
            ),
          ],
        );
      }
    );
  }

  

  void getReplysStream({ required BuildContext context, required Map<String,dynamic> thisComment, required ReplysModel replysModel, required Map<String,dynamic> currentSongMap, required MainModel mainModel })  {
    refreshController = RefreshController(initialRefresh: false);
    routes.toReplysPage(context: context, replysModel: replysModel, currentSongMap: currentSongMap, thisComment: thisComment, mainModel: mainModel);
    final whisperComment = fromMapToWhisperComment(commentMap: thisComment);
    final String commentId = whisperComment.commentId ;
    try {
      if (indexCommentId != commentId) {
        indexCommentId = commentId;
        replysStream = FirebaseFirestore.instance.collection(replysKey).where(elementIdKey,isEqualTo: whisperComment.commentId ).orderBy(createdAtKey,descending: true).limit(limitIndex).snapshots();
      }
    } catch(e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future onLoading(Map<String,dynamic> thisComment) async {
    limitIndex += oneTimeReadCount;
    final whisperComment = fromMapToWhisperComment(commentMap: thisComment);
    switch(sortState) {
      case SortState.byLikedUidCount:
      replysStream = FirebaseFirestore.instance
      .collection(replysKey)
      .where(elementIdKey,isEqualTo: whisperComment.commentId )
      .orderBy(likeCountKey,descending: true )
      .limit(limitIndex)
      .snapshots();
      break;
      case SortState.byNewestFirst:
      replysStream = FirebaseFirestore.instance
      .collection(replysKey)
      .where(elementIdKey,isEqualTo: whisperComment.commentId )
      .orderBy(createdAtKey,descending: true)
      .limit(limitIndex)
      .snapshots();
      break;
      case SortState.byOldestFirst:
      replysStream = FirebaseFirestore.instance
      .collection(replysKey)
      .where(elementIdKey,isEqualTo: whisperComment.commentId )
      .orderBy(createdAtKey,descending: false)
      .limit(limitIndex)
      .snapshots();
      break;
    }
    notifyListeners();
    refreshController.loadComplete();
  }

  Future makeReply({ required Map<String,dynamic> currentSongMap,required MainModel mainModel, required Map<String,dynamic> thisComment}) async {
    final whisperComment = fromMapToWhisperComment(commentMap: thisComment);
    final whisperPost = fromMapToPost(postMap: currentSongMap);
    final elementId = whisperComment.commentId ;
    final currentWhisperUser = mainModel.currentWhisperUser;
    if (ipv6.isEmpty) { ipv6 =  await Ipify.ipv64(); }
    final newReplyMap = makeReplyMap(elementId: elementId, mainModel: mainModel, currentSongMap: currentSongMap);
    await addReplyToFirestore(newReplyMap);
    // notification
    if (whisperPost.uid != currentWhisperUser.uid) {
      final DocumentSnapshot<Map<String,dynamic>> passiveUserDoc = await setPassiveUserDoc(currentSongMap);
      // blocks
      List<dynamic> blocksIpv6s = [];
      List<dynamic> blocksUids = [];
      final List<dynamic> blocksIpv6AndUids = passiveUserDoc[blocksIpv6AndUidsKey];
      blocksIpv6AndUids.forEach((blocksIpv6AndUid) {
        blocksIpv6s.add(blocksIpv6AndUid[ipv6Key]);
        blocksUids.add(blocksIpv6AndUid[uidKey]);
      });
      // mutes
      List<dynamic> mutesUids = [];
      List<dynamic> mutesIpv6s = [];
      final List<dynamic> mutesIpv6AndUids = passiveUserDoc[mutesIpv6AndUidsKey];
      mutesIpv6AndUids.forEach((mutesIpv6AndUid) {
        mutesIpv6s.add(mutesIpv6AndUid[ipv6Key]);
        mutesUids.add(mutesIpv6AndUid[uidKey]);
      });
      if ( isDisplayUid(mutesUids: mutesUids, blocksUids: blocksUids, mutesIpv6s: mutesIpv6s, blocksIpv6s: blocksIpv6s ,uid: currentWhisperUser.uid, ipv6: ipv6) ) {
        await updateReplyNotificationsOfPassiveUser(elementId: elementId, passiveUserDoc: passiveUserDoc, mainModel: mainModel, thisComment: thisComment, newReplyMap: newReplyMap);
      }
    }
  }

  Map<String,dynamic> makeReplyMap({ required String elementId,required  MainModel mainModel, required Map<String,dynamic> currentSongMap}) {
    final currentWhisperUser = mainModel.currentWhisperUser;
    final whisperPost = fromMapToPost(postMap: currentSongMap);
    final newReplyMap = {
      elementIdKey: elementId,
      elementStateKey: elementState,
      createdAtKey: Timestamp.now(),
      followerCountKey: currentWhisperUser.followerCount,
      ipv6Key: ipv6,
      isDeleteKey: false,
      isNFTiconKey: currentWhisperUser.isNFTicon,
      isOfficialKey: currentWhisperUser.isOfficial,
      likeCountKey: 0,
      negativeScoreKey: 0,
      passiveUidKey: whisperPost.uid,
      postIdKey: currentSongMap[postIdKey],
      positiveScoreKey: 0,
      replyKey: reply,
      replyIdKey: replyKey + currentWhisperUser.uid + DateTime.now().microsecondsSinceEpoch.toString() ,
      scoreKey: defaultScore,
      subUserNameKey: currentWhisperUser.subUserName,
      uidKey: currentWhisperUser.uid,
      userNameKey: currentWhisperUser.userName,
      userImageURLKey: currentWhisperUser.imageURL
    };
    return newReplyMap;
  }
  
  Future addReplyToFirestore(Map<String,dynamic> map) async {
    try {
      await FirebaseFirestore.instance.collection(replysKey).doc(map[replyIdKey]).set(map);
    } catch(e) {
      print(e.toString());
    }
  }

  Future setPassiveUserDoc(Map<String,dynamic> currentSongMap) async {
    final whisperPost = fromMapToPost(postMap: currentSongMap);
    final DocumentSnapshot<Map<String,dynamic>> passiveUserDoc = await FirebaseFirestore.instance.collection(usersKey).doc(whisperPost.uid).get();
    return passiveUserDoc;
  }

  Future updateReplyNotificationsOfPassiveUser({ required String elementId, required DocumentSnapshot<Map<String,dynamic>> passiveUserDoc, required MainModel mainModel, required Map<String,dynamic> thisComment, required Map<String,dynamic> newReplyMap }) async {

    final currentWhisperUser = mainModel.currentWhisperUser;
    final whisperComment = fromMapToWhisperComment(commentMap: thisComment);
    final newWhisperReply = fromMapToWhisperReply(replyMap: newReplyMap);
    final passiveWhisperUser = fromMapToWhisperUser(userMap: passiveUserDoc.data()!);
    final String notificationId = 'replyNotification' + currentWhisperUser.uid + DateTime.now().microsecondsSinceEpoch.toString();
    final comment = whisperComment.comment;
    Map<String,dynamic> map = {
      commentKey: comment,
      createdAtKey: Timestamp.now(),
      elementIdKey: elementId,
      elementStateKey: elementState,
      followerCountKey: currentWhisperUser.followerCount,
      isDeleteKey: false,
      isNFTiconKey: currentWhisperUser.isNFTicon,
      isOfficialKey: currentWhisperUser.isOfficial,
      notificationIdKey: notificationId,
      passiveUidKey: passiveWhisperUser.uid,
      postIdKey: whisperComment.postId,
      replyKey: reply,
      replyScoreKey: newWhisperReply.score,
      replyIdKey: newWhisperReply.replyId,
      subUserNameKey: currentWhisperUser.subUserName,
      uidKey: currentWhisperUser.uid,
      userNameKey: currentWhisperUser.userName,
      userImageURLKey: currentWhisperUser.imageURL
    };
    await replyNotificationRef(passiveUid: whisperComment.uid, notificationId: notificationId).set(map);
  }

  Future<void> like({ required Map<String,dynamic> thisReply, required MainModel mainModel }) async {
    // process UI
    final whisperReply = fromMapToWhisperReply(replyMap: thisReply);
    final replyId = whisperReply.replyId;
    final List<dynamic> likeReplyIds = mainModel.likeReplyIds;
    likeReplyIds.add(replyId);
    notifyListeners();
    // backend
    await addLikeSubCol(thisReply: thisReply, mainModel: mainModel);
    await updateLikeReplysOfUser(thisReply: thisReply, mainModel: mainModel);
  }

  Future<void> addLikeSubCol({ required Map<String,dynamic> thisReply,required MainModel mainModel }) async {
    final currentWhisperUser = mainModel.currentWhisperUser;
    final whisperReply = fromMapToWhisperReply(replyMap: thisReply);
    await likeChildRef(parentColKey: replysKey, uniqueId: whisperReply.replyId, activeUid: currentWhisperUser.uid).set({
      uidKey: currentWhisperUser.uid,
      createdAtKey: Timestamp.now(),
    });
  }


  Future<void> updateLikeReplysOfUser({ required Map<String,dynamic> thisReply, required MainModel mainModel}) async {
    try {
      final whisperReply = fromMapToWhisperReply(replyMap: thisReply);
      final newLikedReply = {
        likeReplyIdKey: whisperReply.replyId,
        createdAtKey: Timestamp.now(),
      };
      final List<dynamic> likeReplys = mainModel.likeReplys;
      likeReplys.add(newLikedReply);
      await FirebaseFirestore.instance.collection(usersKey).doc(mainModel.currentWhisperUser.uid)
      .update({
        likeReplysKey: likeReplys,
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future<void> unlike({ required Map<String,dynamic> thisReply, required MainModel mainModel }) async {
    final whisperReply = fromMapToWhisperReply(replyMap: thisReply);
    final replyId = whisperReply.replyId;
    final likeReplyIds = mainModel.likeReplyIds;
    // processUI
    likeReplyIds.remove(replyId);
    notifyListeners();
    // backend
    await deleteLikeSubCol(thisReply: thisReply, mainModel: mainModel);
    await removeLikedReplyOfUser(mainModel: mainModel, thisReply: thisReply);
  }

  Future<void> deleteLikeSubCol({ required Map<String,dynamic> thisReply,required MainModel mainModel }) async {
    final whisperReply = fromMapToWhisperReply(replyMap: thisReply);
    await likeChildRef(parentColKey: replysKey, uniqueId: whisperReply.replyId, activeUid: mainModel.currentWhisperUser.uid).delete();
  }

  Future removeLikedReplyOfUser({ required MainModel mainModel, required Map<String,dynamic> thisReply }) async {
    final List<dynamic> likeReplys = mainModel.likeReplys;
    likeReplys.removeWhere((likedReply) => likedReply[likeReplyIdKey] == thisReply[replyIdKey]);
    await FirebaseFirestore.instance.collection(usersKey).doc(mainModel.currentWhisperUser.uid)
    .update({
      likeReplysKey: likeReplys,
    });
  }
  
}