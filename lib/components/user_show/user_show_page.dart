// material
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// components
import 'package:whisper/details/user_image.dart';
import 'package:whisper/components/user_show/components/details/user_show_button.dart';
import 'package:whisper/components/user_show/components/edit_profile/edit_profile_screen.dart';
import 'package:whisper/components/user_show/components/details/user_show_post_screen.dart';
// models
import 'package:whisper/components/user_show/user_show_model.dart';
import 'package:whisper/components/user_show/components/follow/follow_model.dart';
import 'user_show_model.dart';

class UserShowPage extends ConsumerWidget {
  
  const UserShowPage({
    Key? key,
    required this.currentUserDoc,
    required this.passiveUserDoc,
    required this.bookmarkedPostIds,
    required this.likedPostIds,
    required this.followingUids
  });

  final DocumentSnapshot currentUserDoc;
  final DocumentSnapshot passiveUserDoc;
  final List bookmarkedPostIds;
  final List likedPostIds;
  final List followingUids;
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final userShowModel = watch(userShowProvider);
    final _followProvider = watch(followProvider);
    final List<dynamic> followerUids = currentUserDoc['followerUids'];

    return Scaffold(
      extendBodyBehindAppBar: false,
      body: 
      SafeArea(
        child: userShowModel.isEditing ?
        EditProfileScreen(userShowModel: userShowModel, currentUserDoc: currentUserDoc)
        : Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.9),
                Theme.of(context).primaryColor.withOpacity(0.8),
                Theme.of(context).primaryColor.withOpacity(0.4),
              ]
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  20, 
                  20, 
                  20, 
                  5
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      !userShowModel.isEdited ? passiveUserDoc['userName'] : userShowModel.userName,
                      style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)
                    ),
                    
                    SizedBox(height: 10),
                    Row(
                      children: [
                        UserImage(userImageURL: passiveUserDoc['imageURL'],length: 60.0,padding: 5.0,),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            !userShowModel.isEdited ? passiveUserDoc['description'] : userShowModel.description,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        UserShowButton(
                          currentUserDoc: currentUserDoc, 
                          userDoc: passiveUserDoc, 
                          userShowProvider: userShowModel, 
                          followingUids: followingUids, 
                          followProvider: _followProvider
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'following' +followingUids.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          'follower' + followerUids.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 20,),
                      ],
                    )

                  ],
                ),
              ),
              
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35)
                    )
                  ),
                  child: UserShowPostScreen(
                    currentUserDoc: currentUserDoc,
                    userShowModel: userShowModel, 
                    preservatedPostIds: bookmarkedPostIds, 
                    likedPostIds: likedPostIds
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

