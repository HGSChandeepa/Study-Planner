import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madman/constants/colors.dart';
import 'package:madman/models/assignment_model.dart';
import 'package:madman/pages/notifications_page.dart';
import 'package:madman/services/database/assignment_service.dart';
import 'package:madman/services/database/notifications_service.dart';
import 'package:madman/widgets/countdown_timer.dart';

class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({super.key});

  Future<Map<String, List<Assignment>>> _fetchAssignments() async {
    return await AssignmentService().getAssignmentsWithCourseName();
  }

  Future<void> _checkAndStoreOverdueAssignments() async {
    await NotificationsService().storeOverdueAssignments();
  }

  @override
  Widget build(BuildContext context) {
    // Trigger the method when the screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndStoreOverdueAssignments();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assignments',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, List<Assignment>>>(
        future: _fetchAssignments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No assignments available.'));
          }

          final assignmentsMap = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: assignmentsMap.keys.length,
            itemBuilder: (context, index) {
              final courseName = assignmentsMap.keys.elementAt(index);
              final assignments = assignmentsMap[courseName]!;

              return ExpansionTile(
                title: Text(
                  courseName,
                  style: TextStyle(
                    fontSize: 18,
                    color: darkGreen,
                  ),
                ),
                children: assignments.map((assignment) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    title: Text(
                      assignment.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Due Date: ${DateFormat.yMMMd().format(assignment.dueDate)},', style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white38,
                          ),),
                        Text(
                          'Duration: ${assignment.duration} hours',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white38,
                          ),
                        ),
                        Text('Description: ${assignment.description}', style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white38,
                          ),),
                        CountdownTimer(dueDate: assignment.dueDate,),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
