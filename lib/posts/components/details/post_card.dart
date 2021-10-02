// material
import 'package:flutter/material.dart';
// package
import 'package:cloud_firestore/cloud_firestore.dart';
// constants
import 'package:whisper/constants/colors.dart';
// components
import 'package:whisper/details/user_image.dart';

class PostCard extends StatelessWidget {
  
  const PostCard({
    Key? key,
    required this.postDoc
  }) : super(key: key);

  final DocumentSnapshot postDoc;

  @override  
  Widget build(BuildContext context) {
    final Timestamp timeStamp = postDoc['createdAt'];
    final date = timeStamp.toDate();
    final year = date.year.toString();
    final month = date.month.toString();
    final day = date.day.toString();
    final hour = date.hour.toString();
    final minute = date.minute.toString();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 5)
          )
        ]
      ),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: UserImage(userImageURL: postDoc['userImageURL'], length: 50.0, padding: 0.0),
              title: Text(postDoc['userName']),
              subtitle: Text(
                postDoc['title'],
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              trailing: Text(year + "/" + month + "/" + day + " " + hour + "時" + minute + "分"),
            )
          ],
        ),
      ),
    );
  }
}