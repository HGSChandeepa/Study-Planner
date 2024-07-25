import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madman/models/notification_model.dart';
import 'package:madman/services/database/notifications_service.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  Future<List<NotificationModel>> _fetchNotifications() async {
    return await NotificationsService().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: _fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notifications available.'));
          }

          final notifications = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];

              return ListTile(
                title: Text(
                  notification.assignmentName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Course: ${notification.courseName}'),
                    Text(
                        'Due Date: ${DateFormat.yMMMd().format(notification.dueDate)}'),
                    Text('Time Passed: ${notification.timePassed}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}