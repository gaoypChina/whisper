import 'package:flutter/material.dart';

import 'package:whisper/parts/posts/feeds/feeds_model.dart';

import 'audio_controll_buttons.dart';
import 'audio_progress_bar.dart';
import 'current_song_title.dart';

import 'package:whisper/constants/routes.dart' as routes;
class AudioStateDesign extends StatelessWidget {
  
  AudioStateDesign(this.feedsProvider);
  final FeedsModel feedsProvider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // feeds_show
        routes.toFeedShowPage(context, feedsProvider.currentSongDoc, feedsProvider);
      },
      child: Container(
        height: 130,
        child: Column(
          children: [
            AudioControllButtons(feedsProvider),
            AudioProgressBar(feedsProvider),
            CurrentSongTitle(feedsProvider)
          ],
        ),
      ),
    );
  }
}
