import 'package:flutter/material.dart';
import 'package:whisper/parts/posts/feeds/feeds_model.dart';

import 'package:whisper/parts/posts/feeds/audio_controll/audio_window.dart';

class PostCard extends StatelessWidget{
  PostCard(this.feedsProvider,this.preservatedPostIds,this.likedPostIds);
  final FeedsModel feedsProvider;
  final List preservatedPostIds;
  final List likedPostIds;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: feedsProvider.feedDocs.length,
            itemBuilder: (BuildContext context, int i) =>
              ListTile(
                title: Text(feedsProvider.feedDocs[i]['title']),
                
              )
          ),
        ),
        AudioWindow(feedsProvider, preservatedPostIds, likedPostIds),
       
      ]
    );
  }
}