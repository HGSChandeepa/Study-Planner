import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String assignmentName;
  final String courseName;
  final DateTime dueDate;
  final String timePassed; // You may choose to format this as needed

  NotificationModel({
    required this.id,
    required this.assignmentName,
    required this.courseName,
    required this.dueDate,
    required this.timePassed,
  });

  // Convert a Notification instance into a Map
  Map<String, dynamic> toJson() {
    return {
      'assignmentName': assignmentName,
      'courseName': courseName,
      'dueDate': Timestamp.fromDate(dueDate),
      'timePassed': timePassed,
    };
  }

  // Convert a Map into a Notification instance
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      assignmentName: json['assignmentName'] ?? '',
      courseName: json['courseName'] ?? '',
      dueDate: (json['dueDate'] as Timestamp).toDate(),
      timePassed: json['timePassed'] ?? '',
    );
  }
}
