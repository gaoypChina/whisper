// material
import 'package:flutter/material.dart';
// components
import 'package:whisper/details/redirect_user_image.dart';
import 'package:whisper/components/search/post_search/components/comments/components/comment_like_button.dart';
import 'package:whisper/components/search/post_search/components/replys/components/reply_card/components/show_replys_button.dart';
// models
import 'package:whisper/main_model.dart';
import 'package:whisper/components/search/post_search/components/replys/search_replys_model.dart';
import 'package:whisper/components/search/post_search/components/comments/search_comments_model.dart';

class CommentCard extends StatelessWidget {

  const CommentCard({
    Key? key,
    required this.comment,
    required this.searchCommentsModel,
    required this.searchReplysModel,
    required this.currentSongMap,
    required this.mainModel
  }): super(key: key);
  
  final Map<String,dynamic> comment;
  final SearchCommentsModel searchCommentsModel;
  final SearchReplysModel searchReplysModel;
  final Map<String,dynamic> currentSongMap;
  final MainModel mainModel;

  @override  
  Widget build(BuildContext context){
    final commentId = comment['commentId'];
    
    return Card(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(4.0))
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0
                    ),
                    // child: UserImage(userImageURL: comment['userImageURL'], length: 60.0, padding: 0.0),
                    child: RedirectUserImage(userImageURL: comment['userImageURL'], length: 60.0, padding: 0.0, passiveUserDocId: comment['userDocId'], mainModel: mainModel),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        children: [
                          Text(comment['userName']),
                          SizedBox(height: 10.0,),
                          Text(comment['comment'])
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CommentLikeButton(searchCommentsModel: searchCommentsModel, currentUserDoc: mainModel.currentUserDoc, currentSongMap: currentSongMap, likedCommentIds: mainModel.likedCommentIds, commentId: commentId,likedComments: mainModel.likedComments),
                      if(comment['uid'] == currentSongMap['uid'] ) ShowReplyButton(searchReplysModel: searchReplysModel,currentSongMap: currentSongMap,currentUserDoc: mainModel.currentUserDoc,thisComment: comment,)
                    ],
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}