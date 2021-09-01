import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/parts/posts/posts_futures.dart';

class PreservateButton extends ConsumerWidget {
  PreservateButton(this.uid,this.postDoc);
  final String uid;
  final DocumentSnapshot postDoc;
  @override  
  Widget build(BuildContext context, ScopedReader watch) {
    final _postsFeaturesProvider = watch(postsFeaturesProvider);
    return IconButton(
      icon: Icon(Icons.inventory_2),
      onPressed: () async {
        await _postsFeaturesProvider.preservate(uid, postDoc);
        
      }, 
    );
  }
}