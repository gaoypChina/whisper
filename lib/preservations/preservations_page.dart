import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/parts/nothing.dart';
import 'package:whisper/preservations/preservations_model.dart';
import 'package:whisper/preservations/audio_controll/audio_window.dart';

import 'package:whisper/parts/loading.dart';

class PreservationsPage extends ConsumerWidget {
  PreservationsPage(this.preservatedPostIds,this.likedPostIds);
  final List preservatedPostIds;
  final List likedPostIds;
  @override 
  Widget build(BuildContext context, ScopedReader watch) {
    final _preservationsProvider = watch(preservationsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('preservations'),
      ),
      body: PostScreen(preservationsProvider: _preservationsProvider, preservatedPostIds: preservatedPostIds, likedPostIds: likedPostIds)
    );
  }
}

class PostScreen extends StatelessWidget {
  const PostScreen({
    Key? key,
    required PreservationsModel preservationsProvider,
    required this.preservatedPostIds,
    required this.likedPostIds,
  }) : _preservationsProvider = preservationsProvider, super(key: key);

  final PreservationsModel _preservationsProvider;
  final List preservatedPostIds;
  final List likedPostIds;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _preservationsProvider.isLoading ?
      Loading()
      : _preservationsProvider.preservationDocs.isEmpty ?
      Nothing()
      : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _preservationsProvider.preservationDocs.length,
                itemBuilder: (BuildContext context, int i) =>
                  ListTile(
                    title: Text(_preservationsProvider.preservationDocs[i]['title']),
                  )
              ),
            ),
            AudioWindow(_preservationsProvider,preservatedPostIds,likedPostIds)
          ],
        ),
    );
  }
}