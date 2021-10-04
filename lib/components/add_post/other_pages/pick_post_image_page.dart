// material
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
// components
import 'package:whisper/details/rounded_button.dart';
import 'package:whisper/components/add_post/components/audio_buttons/upload_button.dart';
// model
import 'package:whisper/components/add_post/add_post_model.dart';

class PickPostImagePage extends StatelessWidget {
  
  const PickPostImagePage({
    Key? key,
    required this.addPostModel,
    required this.currentUserDoc
  }) : super(key: key);

  final AddPostModel addPostModel;
  final DocumentSnapshot currentUserDoc;
  
  @override 
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('image'),
      ),
      body: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: addPostModel.isCroppedNotifier,
          builder: (_,value,__) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.width * 0.6,
                  width: size.width * 0.6,
                  child: value ? Image.file(addPostModel.croppedFile!) : Image.network(currentUserDoc['imageURL']),
                ),
                RoundedButton(
                  text: value ? '写真を変更する' :'写真を追加(任意)', 
                  widthRate: 0.95,
                  verticalPadding: 20.0, 
                  horizontalPadding: 10.0,
                  press: () async {
                    await addPostModel.showImagePicker();
                  }, 
                  textColor: Colors.white, 
                  buttonColor: value ? Theme.of(context).primaryColor : Theme.of(context).highlightColor
                ),
                UploadButton(addPostModel: addPostModel, currentUserDoc: currentUserDoc)
              ],
            );
          }
        ),
      ),
    );
  }
}