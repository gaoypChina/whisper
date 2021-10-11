// material
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// model
import 'package:whisper/main_model.dart';
import 'package:whisper/components/search/post_search/components/post_buttons/posts_futures.dart';

class LikeButton extends ConsumerWidget {
  
  const LikeButton({
    required this.currentUserDoc,
    required this.currentSongMapNotifier,
    required this.mainModel
  });
  
  final DocumentSnapshot currentUserDoc;
  final ValueNotifier<Map<String,dynamic>> currentSongMapNotifier;
  final MainModel mainModel;
  @override  
  Widget build(BuildContext context, ScopedReader watch) {
    final postFuturesModel = watch(postsFeaturesProvider);
    return 
    ValueListenableBuilder<Map<String,dynamic>>(
      valueListenable: currentSongMapNotifier, 
      builder: (_, currentSongMap, __) {
        return
        mainModel.likedPostIds.contains(currentSongMap['postId']) ?
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: () async {
            mainModel.likedPostIds.remove(currentSongMap['postId']);
            postFuturesModel.reload();
            await postFuturesModel.unlike(currentUserDoc, currentSongMap, mainModel.likes);
          }, 
        )
        : IconButton(
          icon: Icon(Icons.favorite),
          onPressed: () async {
            mainModel.likedPostIds.add(currentSongMap['postId']);
            postFuturesModel.reload();
            await postFuturesModel.like(currentUserDoc, currentSongMap,mainModel.likes);
          }, 
        );
      }
    );
  }
}