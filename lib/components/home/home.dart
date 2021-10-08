// material
import 'package:flutter/material.dart';
// constants
import 'package:whisper/components/home/constants/tab_bar_elements.dart';
// components
import 'package:whisper/details/notification_icon.dart';
import 'package:whisper/details/whisper_drawer.dart';
// pages
import 'package:whisper/components/home/feeds/feeds_page.dart';
import 'package:whisper/components/home/recommenders/recommenders_page.dart';
// model
import 'package:whisper/main_model.dart';
import 'package:whisper/themes/themes_model.dart';


class Home extends StatelessWidget {

  const Home({
    Key? key,
    required this.mainModel,
    required this.themeModel,
    required this.bookmarkedPostIds,
    required this.likedPostIds,
    required this.likedCommentIds,
    required this.likedComments,
    required this.bookmarks,
    required this.likes,
    required this.replyNotifications,
    required this.readPostIds,
    required this.readPosts,
    required this.readNotificationIds
  }) : super(key: key);
  
  final MainModel mainModel;
  final ThemeModel themeModel;
  final List bookmarkedPostIds;
  final List likedPostIds;
  final List likedCommentIds;
  final List likedComments;
  final List bookmarks;
  final List likes;
  final List replyNotifications;
  final List readPostIds;
  final List readPosts;
  final List readNotificationIds;

  @override  
  Widget build(BuildContext context) {
    final currentUserDoc = mainModel.currentUserDoc;
    return DefaultTabController(
      length: tabBarElements.length, 
      child: Scaffold(
        appBar: AppBar(
          title: Text('Whisper'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30)
            )
          ),
          actions: [
            NotificationIcon(
              mainModel: mainModel, 
              themeModel: themeModel, 
              bookmarkedPostIds: bookmarkedPostIds, 
              likedPostIds: likedPostIds, 
              replyNotifications: replyNotifications, 
              currentUserDoc: currentUserDoc,
              readNotificationIds: readNotificationIds,
            )
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: tabBarElements.map((tabBarElement) {
              return Tab(
                text: tabBarElement.title
              );
            }).toList()
          ),
        ),
        
        drawer: WhisperDrawer(
          mainModel: mainModel,
          themeModel: themeModel,
        ),
        body: TabBarView(
          children: [
            FeedsPage(
              bookmarkedPostIds: bookmarkedPostIds, 
              likedPostIds: likedPostIds,
              likedCommentIds: likedCommentIds,
              likedComments: likedComments,
              bookmarks: bookmarks,
              likes: likes,
              readPostIds: readPostIds,
              readPosts: readPosts,
            ),
            RecommendersPage(
              currentUserDoc: mainModel.currentUserDoc, 
              bookmarkedPostIds: bookmarkedPostIds, 
              likedPostIds: likedPostIds,
              likedCommentIds: likedCommentIds,
              likedComments: likedComments,
              bookmarks: bookmarks,
              likes: likes,
              readPostIds: readPostIds,
              readPosts: readPosts,
            )
          ],
        ),
        
      )
    );
  }
}