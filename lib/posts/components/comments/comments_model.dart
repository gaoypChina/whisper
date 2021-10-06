// material
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// components
import 'package:whisper/details/rounded_button.dart';

final commentsProvider = ChangeNotifierProvider(
  (ref) => CommentsModel()
);

class CommentsModel extends ChangeNotifier {
  

  // comment
  String comment = "";
  Map<String,dynamic> postComment = {};
  // change
  List<dynamic> comments = [];
  bool didCommented = false;
  List<dynamic> postComments = [];
  List<dynamic> likedComments = [];

  void reload() {
    notifyListeners();
  }

  void onFloatingActionButtonPressed(BuildContext context,DocumentSnapshot currentSongDoc,TextEditingController commentEditingController,DocumentSnapshot currentUserDoc) {
    showDialog(
      context: context, 
      builder: (_) {
        return AlertDialog(
          title: Text('comment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  child: TextField(
                    controller: commentEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      comment = text;
                    },
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'cancel',
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
              onPressed: () { 
                Navigator.pop(context);
              },
            ),
            RoundedButton(
              text: '送信', 
              widthRate: 0.95, 
              verticalPadding: 10.0, 
              horizontalPadding: 10.0, 
              press: () async { 
                await makeComment(currentSongDoc, currentUserDoc); 
                comment = '';
                Navigator.pop(context);
              }, 
              textColor: Colors.white, 
              buttonColor: Theme.of(context).primaryColor
            )
          ],
        );
      }
    );
  }

  Future makeComment(DocumentSnapshot currentSongDoc,DocumentSnapshot currentUserDoc) async {
    didCommented = true;
    notifyListeners();
    final DocumentSnapshot newCurrentSongDoc = await getNewCurrentSongDoc(currentSongDoc);
    await updateCommentsOfPostWhenMakeComment(newCurrentSongDoc, currentUserDoc);
    final DocumentSnapshot passiveUserDoc = await setPassiveUserDoc(currentSongDoc['userDocId']);
    await updateCommentNotificationsOfPassiveUser(currentSongDoc, currentUserDoc,passiveUserDoc);
  }


  Future updateCommentsOfPostWhenMakeComment(DocumentSnapshot newCurrentSongDoc, DocumentSnapshot currentUserDoc) async {
    try{
      final commentMap = {
        'comment': comment,
        'commentId': currentUserDoc['uid'] + DateTime.now().microsecondsSinceEpoch.toString(),
        'createdAt': Timestamp.now(),
        'likesUids': [],
        'uid': currentUserDoc['uid'],
        'userName': currentUserDoc['userName'],
        'userImageURL': currentUserDoc['imageURL'],
      };
      comments = newCurrentSongDoc['comments'];
      
      comments.add(commentMap);
      print(comments.length.toString());
      await FirebaseFirestore.instance
      .collection('posts')
      .doc(newCurrentSongDoc.id)
      .update({
        'comments': comments,
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future updateCommentNotificationsOfPassiveUser(DocumentSnapshot currentSongDoc,DocumentSnapshot currentUserDoc,DocumentSnapshot passiveUserDoc) async {
    try{
      List<dynamic> commentNotifications = passiveUserDoc['commentNotifications'];

      final Map<String,dynamic> newCommentNotificationMap = {
        'comment': comment,
        'createdAt': Timestamp.now(),
        'postId': 'commentNotification' + currentUserDoc['uid'] + DateTime.now().microsecondsSinceEpoch.toString(),
        'postTitle': currentSongDoc['title'],
        'uid': currentUserDoc['uid'],
        'userDocId': currentUserDoc.id,
        'userName': currentUserDoc['userName'],
        'userImageURL': currentUserDoc['userImageURL'],
      };
      commentNotifications.add(newCommentNotificationMap);
      await FirebaseFirestore.instance
      .collection('users')
      .doc(passiveUserDoc.id)
      .update({
        'commentNotifications': commentNotifications,
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future like(DocumentSnapshot currentUserDoc,DocumentSnapshot currentSongDoc,String commentId,List<dynamic> likedComments) async {
    final DocumentSnapshot newCurrentSongDoc = await getNewCurrentSongDoc(currentSongDoc);
    await updateCommentsOfPostWhenSomeoneLiked(newCurrentSongDoc, commentId, currentUserDoc);
    await updateLikedCommentsOfCurrentUser(commentId, likedComments, currentUserDoc);
  }
  

  Future updateCommentsOfPostWhenSomeoneLiked(DocumentSnapshot newCurrentSongDoc,String commentId,DocumentSnapshot currentUserDoc) async {

    postComments = newCurrentSongDoc['comments'];
    //Likeが押された時のPost側の処理
    try{
      postComments.forEach((postComment) {
        if (postComment['commentId'] == commentId){
          // likesUids
          List<dynamic> likesUids = postComment['likesUids'];
          likesUids.add(currentUserDoc['uid']);
          FirebaseFirestore.instance
          .collection('posts')
          .doc(newCurrentSongDoc.id)
          .update({
            'comments': postComments,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future updateLikedCommentsOfCurrentUser(String commentId,List<dynamic> likedComments,DocumentSnapshot currentUserDoc) async {
    // User側の処理
    likedComments = likedComments;
    Map<String,dynamic> map = {
      'commentId': commentId,
      'createdAt': Timestamp.now(),
    };

    likedComments.add(map);
    await FirebaseFirestore.instance
    .collection('users')
    .doc(currentUserDoc.id)
    .update({
      'likedComments': likedComments,
    });

  }


  Future setPassiveUserDoc(String passiveUserDocId) async {
    DocumentSnapshot passiveUserDoc = await FirebaseFirestore.instance
    .collection('users')
    .doc(passiveUserDocId)
    .get();
    return passiveUserDoc;
  }

  Future getNewCurrentSongDoc(DocumentSnapshot currentSongDoc) async {
    DocumentSnapshot newCurrentSongDoc = await FirebaseFirestore.instance
    .collection('users')
    .doc(currentSongDoc.id)
    .get();
    return newCurrentSongDoc;
  }

}