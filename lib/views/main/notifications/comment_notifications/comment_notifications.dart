// material
import 'package:flutter/material.dart';
import 'package:whisper/constants/strings.dart';
// components
import 'package:whisper/details/refresh_screen.dart';
import 'package:whisper/views/main/notifications/comment_notifications/components/comment_notification_card.dart';
// domain
import 'package:whisper/domain/comment_notification/comment_notification.dart';
// model
import 'package:whisper/main_model.dart';
import 'package:whisper/models/main/notifications_model.dart';

class CommentNotifications extends StatelessWidget {

  const CommentNotifications({
    Key? key,
    required this.mainModel,
    required this.notificationsModel,
  }) : super(key: key);

  final MainModel mainModel;
  final NotificationsModel notificationsModel;

  @override
  Widget build(BuildContext context) {
    final List<CommentNotification> commentNotifications = notificationsModel.notifications.where((element) => CommentNotification.fromJson(element.data()!).notificationType == commentNotificationType ).map((e) => CommentNotification.fromJson(e.data()!) ).toList();
    return RefreshScreen(
      isEmpty: commentNotifications.isEmpty,
      subWidget: SizedBox.shrink(),
      controller: notificationsModel.commentRefreshController,
      onRefresh: () async => await notificationsModel.onRefresh(),
      onReload: () async => await notificationsModel.onReload(),
      onLoading: () async => await notificationsModel.onLoading(),
      child: ListView.builder(
        itemCount: commentNotifications.length,
        itemBuilder: (BuildContext context, int i) {
          final CommentNotification notification = commentNotifications[i];
          return CommentNotificationCard(commentNotification: notification, mainModel: mainModel,notificationsModel: notificationsModel, );
        }
      ),
    );
  }
}