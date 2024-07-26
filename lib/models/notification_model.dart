import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {

  final String assignmentId;
  final String assignmentName;
  final String courseName;
  final String description;
  final DateTime dueDate;
  final String timePassed; 

  NotificationModel({
  
    required this.assignmentId,
    required this.assignmentName,
    required this.courseName,
    required this.description,
    required this.dueDate,
    required this.timePassed,
  });

  // Convert a Notification instance into a Map
  Map<String, dynamic> toJson() {
    return {
      'assignmentId': assignmentId,
      'assignmentName': assignmentName,
      'courseName': courseName,
      'description': description,
      'dueDate': Timestamp.fromDate(dueDate),
      'timePassed': timePassed,
    };
  }

  // Convert a Map into a Notification instance
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      assignmentId: json['assignmentId'] ?? '',
      assignmentName: json['assignmentName'] ?? '',
      courseName: json['courseName'] ?? '',
      description: json['description'] ?? '',
      dueDate: (json['dueDate'] as Timestamp).toDate(),
      timePassed: json['timePassed'] ?? '',
    );
  }
}
