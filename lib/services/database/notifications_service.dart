import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madman/models/notification_model.dart';
import 'package:madman/services/database/assignment_service.dart';

class NotificationsService {
  // Method to store overdue assignments as notifications
  Future<void> storeOverdueAssignments() async {
    final CollectionReference notificationCollection =
        FirebaseFirestore.instance.collection('notifications');
    try {
      final assignmentsMap =
          await AssignmentService().getAssignmentsWithCourseName();

      for (final entry in assignmentsMap.entries) {
        final courseName = entry.key;
        final assignments = entry.value;

        for (final assignment in assignments) {
          //check weather the assignment is already exsist in the notification collection
          final QuerySnapshot snapshot = await notificationCollection
              .where('assignmentId', isEqualTo: assignment.id)
              .get();

          if (snapshot.docs.isEmpty) {
            if (DateTime.now().isAfter(assignment.dueDate)) {
              await notificationCollection.add({
                'assignmentId': assignment.id,
                'courseName': courseName,
                'title': assignment.name,
                'description': assignment.description,
                'dueDate': assignment.dueDate,
                'time': Timestamp.now(),
              });
            }
          }
        }
      }
    } catch (error) {
      print(error);
    }
  }

  // Method to get all notifications
  Future<List<NotificationModel>> getNotifications() async {
    final CollectionReference notificationCollection =
        FirebaseFirestore.instance.collection('notifications');
    try {
      final QuerySnapshot snapshot = await notificationCollection.get();
      return snapshot.docs
          .map((doc) =>
              NotificationModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print(error);
      return [];
    }
  }
}
