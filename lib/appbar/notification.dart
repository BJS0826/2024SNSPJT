import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: NotificationPage(),
    ),
  );
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알림'),
      ),
      body: NotificationList(),
    );
  }
}

class NotificationList extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(type: NotificationType.FollowRequest, user: '사용자1'),
    NotificationItem(type: NotificationType.Like, user: '사용자2'),
    NotificationItem(type: NotificationType.FriendRecommendation, user: '사용자3'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(notifications[index].getTitle()),
          subtitle: Text(notifications[index].getSubtitle()),
          onTap: () {
            _showNotificationDetail(context, notifications[index]);
          },
        );
      },
    );
  }

  void _showNotificationDetail(
      BuildContext context, NotificationItem notification) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(notification.getTitle()),
          content: Text(notification.getDetail()),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }
}

enum NotificationType { FollowRequest, Like, FriendRecommendation }

class NotificationItem {
  final NotificationType type;
  final String user;

  NotificationItem({required this.type, required this.user});

  String getTitle() {
    switch (type) {
      case NotificationType.FollowRequest:
        return '$user님이 팔로우 요청을 보냈습니다.';
      case NotificationType.Like:
        return '$user님이 회원님의 글을 좋아합니다.';
      case NotificationType.FriendRecommendation:
        return '새로운 친구를 추천합니다: $user';
    }
  }

  String getSubtitle() {
    return '방금 전';
  }

  String getDetail() {
    // 각 알림에 대한 상세 정보를 반환하는 로직을 추가할 수 있습니다.
    return '알림 상세 내용';
  }
}
