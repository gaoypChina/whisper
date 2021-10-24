// material
import 'package:flutter/material.dart';
// components
import 'package:whisper/components/add_post/components/audio_buttons/audio_button.dart';
// notifier
import 'package:whisper/components/add_post/components/notifiers/add_post_state_notifier.dart';
// model
import 'package:whisper/components/add_post/add_post_model.dart';

class RecordButton extends StatelessWidget {

  RecordButton(this.addPostModel);
  final AddPostModel addPostModel;
  @override  
  Widget build(BuildContext context) {
    return 
    ValueListenableBuilder<AddPostState>(
      valueListenable: addPostModel.addPostStateNotifier,
      builder: (_,value,__) {
        return AudioButton(
          description: value == AddPostState.recording ?
          '停止する'
          : '録音する',
          icon: value == AddPostState.recording ?
          Icon(Icons.pause, size: 100.0,)
          : Icon(
            Icons.fiber_manual_record,
            color: Theme.of(context).highlightColor,
            size: 100.0,
          ),
          press: () async {
            addPostModel.onRecordButtonPressed(context);
          }
        );
      }
    );
  }
}
