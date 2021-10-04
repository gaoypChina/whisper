// material
import 'package:flutter/material.dart';
// package
import 'package:cloud_firestore/cloud_firestore.dart';
// components
import 'package:whisper/components/user_show/components/follow/follow_model.dart';
import 'package:whisper/details/rounded_button.dart';
// model
import 'package:whisper/components/user_show/user_show_model.dart';

class UserShowButton extends StatelessWidget {
  
  const UserShowButton({
    Key? key,
    required this.currentUserDoc,
    required this.userDoc,
    required this.userShowProvider,
    required this.followingUids,
    required this.followProvider
  }) : super(key: key);

  final DocumentSnapshot currentUserDoc;
  final DocumentSnapshot userDoc;
  final UserShowModel userShowProvider;
  final List followingUids;
  final FollowModel followProvider;
  @override 
  Widget build(BuildContext context) {
    return userDoc.id == currentUserDoc.id ?
    // 変更
    RoundedButton(
      text: '編集', 
      widthRate: 0.25,
      verticalPadding: 20.0,
      horizontalPadding: 0.0,
      press: () {
        userShowProvider.onEditButtonPressed(currentUserDoc);
      }, 
      textColor: Colors.white, 
      buttonColor: Theme.of(context).highlightColor
    )
    : !followingUids.contains(userDoc['uid']) ?
    RoundedButton(
      text: 'follow', 
      widthRate: 0.35,
      verticalPadding: 20.0,
      horizontalPadding: 10.0,
      press: () async {
        try {
          followingUids.add(userDoc['uid']);
          followProvider.reload();
          await followProvider.follow(followingUids, currentUserDoc, userDoc);
        } catch(e) {
          print(e.toString());          
        }
      }, 
      textColor: Colors.white, 
      buttonColor: Theme.of(context).highlightColor
    )
    : RoundedButton(
      text: 'unfollow', 
      widthRate: 0.35,
      verticalPadding: 20.0,
      horizontalPadding: 10.0,
      press: () async {
        try {
          followingUids.remove(userDoc['uid']);
          followProvider.reload();
          await followProvider.unfollow(followingUids, currentUserDoc, userDoc);
        } catch(e) {
          print(e.toString());          
        }
      },  
      textColor: Colors.white, 
      buttonColor: Theme.of(context).colorScheme.secondary
    );
    
  }
}