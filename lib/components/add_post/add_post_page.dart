// material
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
// components
import 'package:whisper/details/gradient_screen.dart';
// model
import 'add_post_model.dart';
import 'package:whisper/components/add_post/components/add_post_content/add_post_content.dart';

class AddPostPage extends StatelessWidget {

  AddPostPage({
    Key? key,
    required this.currentUserDoc,
    required this.addPostModel
  }) : super(key: key);

  final DocumentSnapshot currentUserDoc;
  final AddPostModel addPostModel;
  
  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientScreen(
        top: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }, 
              ),
            ),
          ],
        ),
        header: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '投稿する',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold
            )
          ),
        ),
        content: AddPostContent(addPostModel: addPostModel, currentUserDoc: currentUserDoc),
        circular: 35.0,
      ),
    );
  }
}
