// material
import 'package:flutter/material.dart';
// package
import 'package:cloud_firestore/cloud_firestore.dart';
// components
import 'package:whisper/posts/components/post_buttons/components/edit_button.dart';
import 'package:whisper/posts/components/post_buttons/components/like_button.dart';
import 'package:whisper/posts/components/post_buttons/components/bookmark_button.dart';
import 'package:whisper/posts/components/post_buttons/components/comment_button.dart';
import 'package:whisper/posts/components/post_buttons/components/redirect_to_url_button.dart';
// models
import 'package:whisper/main_model.dart';
import 'package:whisper/posts/components/other_pages/post_show/components/edit_post_info/edit_post_info_model.dart';

class PostButtons extends StatelessWidget {

  const PostButtons({
    required this.currentSongDocNotifier,
    required this.toCommentsPage,
    required this.toEditingMode,
    required this.mainModel,
    required this.editPostInfoModel
  });

  final ValueNotifier<DocumentSnapshot?> currentSongDocNotifier;
  final void Function()? toCommentsPage;
  final void Function()? toEditingMode;
  final MainModel mainModel;
  final EditPostInfoModel editPostInfoModel;
  
  @override  
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        LikeButton(currentUserDoc: mainModel.currentUserDoc, currentSongDocNotifier: currentSongDocNotifier, likedPostIds: mainModel.likedPostIds,likes: mainModel.likes),
        BookmarkButton(currentUserDoc: mainModel.currentUserDoc, currentSongDocNotifier: currentSongDocNotifier, bookmarkedPostIds: mainModel.bookmarkedPostIds,bookmarks: mainModel.bookmarks),
        CommentButton(currentSongDocNotifier: currentSongDocNotifier,mainModel: mainModel,toCommentsPage: toCommentsPage),
        EditButton(currentUserDoc: mainModel.currentUserDoc, currentSongDocNotifier: currentSongDocNotifier, toEditingMode: toEditingMode,),
        // RedirectToUrlButton(url: currentSongDocNotifier.value!['link'])
        RedirectToUrlButton(currentSongDocNotifier: currentSongDocNotifier,)
      ],
    );
  }
}