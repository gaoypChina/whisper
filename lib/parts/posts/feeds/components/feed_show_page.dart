import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whisper/constants/colors.dart';
import 'package:whisper/parts/posts/feeds/feeds_model.dart';
import 'package:whisper/parts/posts/feeds/audio_controll/audio_state_design.dart';

import 'package:whisper/parts/posts/post_buttons/post_buttons.dart';

import 'package:whisper/parts/comments/comments.dart';

class FeedShowPage extends StatelessWidget{
  final DocumentSnapshot doc;
  final FeedsModel feedsProvider;
  final List preservatedPostIds;
  final List likedPostIds;
  FeedShowPage(this.doc,this.feedsProvider,this.preservatedPostIds,this.likedPostIds);
  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        backgroundColor: kBackgroundColor,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10
              ),
              child: IconButton(
                icon: Icon(Icons.keyboard_arrow_down),
                onPressed: (){
                  Navigator.pop(context);
                }, 
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    // image
                    child: Text(doc.id),
                  ),
                  Center(
                    child: Text(doc['title']),
                  ),
                  PostButtons(
                    feedsProvider.currentUser!.uid,
                    doc,
                    preservatedPostIds,
                    likedPostIds
                  ),
                  AudioStateDesign(feedsProvider,preservatedPostIds,likedPostIds),
                  Comments(feedsProvider.currentSongDoc['postId'])
                ],
              ),
            ),
          ],
        ),
      );
      
  }
}