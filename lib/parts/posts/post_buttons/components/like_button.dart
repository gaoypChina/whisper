import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whisper/parts/posts/posts_futures.dart';

class LikeButton extends ConsumerWidget {
  LikeButton(this.uid,this.postDoc);
  final String uid;
  final DocumentSnapshot postDoc;
  
  @override  
  Widget build(BuildContext context, ScopedReader watch) {
    final _postFeaturesProvider = watch(postsFeaturesProvider);
    return IconButton(
      icon: Icon(Icons.favorite),
      onPressed: () async {
        await _postFeaturesProvider.like(uid, postDoc);
      }, 
    );
  }
}