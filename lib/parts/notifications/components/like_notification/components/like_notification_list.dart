import 'package:flutter/material.dart';

import 'package:whisper/parts/notifications/components/like_notification/components/like_notification_card.dart';

class LikeNotificationList extends StatelessWidget {

  LikeNotificationList(this.notifications);

  final List<dynamic> notifications;
  
  @override 
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int i) =>
      LikeNotificationCard(
        notifications[i]
      )
    );
  }
}