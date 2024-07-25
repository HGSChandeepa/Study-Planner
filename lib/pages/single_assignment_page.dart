import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madman/models/assignment_model.dart';

class SingleAssignmentScreen extends StatelessWidget {
  final Assignment assignment;

  const SingleAssignmentScreen({required this.assignment, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment: ${assignment.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${assignment.name}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Description:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(assignment.description),
            const SizedBox(height: 10),
            Text(
              'Due Date:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(DateFormat.yMMMd().format(assignment.dueDate)),
            const SizedBox(height: 10),
            Text(
              'Time:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(DateFormat.Hm().format(assignment.dueDate)),
          ],
        ),
      ),
    );
  }
}
