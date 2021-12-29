// material
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// package
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// components
import 'package:whisper/details/loading.dart';
import 'package:whisper/details/gradient_screen.dart';
import 'package:whisper/components/search/user_search/components/user_result.dart';
// models
import 'package:whisper/main_model.dart';
import 'package:whisper/components/search/ranking/user_ranking_model.dart';

class UserRankingPage extends ConsumerWidget {
  
  const UserRankingPage({
    Key? key,
    required this.mainModel
  }) : super(key: key);

  final MainModel mainModel;

  @override 
  Widget build(BuildContext context, ScopedReader watch) {
    final userRankingModel = watch(userRankingProvider);
    return GradientScreen(
        top: SizedBox.shrink(), 
        header: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'User Ranking',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      circular: 35.0,
      content: userRankingModel.isLoading ?
      SizedBox.shrink()
      : SmartRefresher(
        controller: userRankingModel.refreshController,
        enablePullDown: false,
        enablePullUp: true,
        header: WaterDropHeader(),
        onLoading: () async { await userRankingModel.onLoading(); },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0
          ),
          child: ListView.builder(
            itemCount: userRankingModel.userDocs.length,
            itemBuilder: (BuildContext context, int i) {
              final DocumentSnapshot<Map<String,dynamic>> userDoc = userRankingModel.userDocs[i];
              return mainModel.mutesUids.contains(userDoc['uid']) || mainModel.blocksUids.contains(userDoc['uid']) ?
              ListTile(
                title: Text('非表示'),
                leading: Icon(Icons.block),
              )
              : UserResult(result: userDoc.data()!, mainModel: mainModel);
            }
          ),
        ),
      ), 
    );
  }
}