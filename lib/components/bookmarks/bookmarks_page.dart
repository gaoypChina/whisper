// material
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// components
import 'package:whisper/details/loading.dart';
import 'package:whisper/components/bookmarks/components/post_screen.dart';
// model
import 'package:whisper/main_model.dart';
import 'package:whisper/components/bookmarks/bookmarks_model.dart';

class BookmarksPage extends ConsumerWidget {
  
  const BookmarksPage({
    Key? key,
    required this.mainModel
  }) : super(key: key);
  
  final MainModel mainModel;

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksModel = ref.watch(bookmarksProvider);
    return Scaffold(
      body: bookmarksModel.isLoading ? Loading() : PostScreen(bookmarksModel: bookmarksModel, mainModel: mainModel),
    );
  }
}

