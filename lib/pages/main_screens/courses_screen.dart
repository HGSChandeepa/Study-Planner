import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:madman/constants/colors.dart';
import 'package:madman/models/assignment_model.dart';
import 'package:madman/models/course_model.dart';
import 'package:madman/models/note_model.dart';
import 'package:madman/services/database/assignment_service.dart';
import 'package:madman/services/database/course_service.dart';
import 'package:madman/services/database/note_service.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  Future<Map<String, dynamic>> _fetchData() async {
    try {
      final courses = await CourseService().getCourses();
      final assignmentsMap =
          await AssignmentService().getAssignmentsWithCourseName();
      final notesMap = await NoteService().getNotesWithCourseName();

      return {
        'courses': courses,
        'assignments': assignmentsMap,
        'notes': notesMap,
      };
    } catch (error) {
      print('Error fetching data: $error');
      return {
        'courses': [],
        'assignments': {},
        'notes': {},
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              GoRouter.of(context).push('/notifications');
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available.'));
          }

          final courses = snapshot.data!['courses'] as List<Course>? ?? [];
          final assignmentsMap =
              snapshot.data!['assignments'] as Map<String, List<Assignment>>? ??
                  {};
          final notesMap =
              snapshot.data!['notes'] as Map<String, List<Note>>? ?? {};

          if (courses.isEmpty) {
            return const Center(child: Text('No courses available.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              final courseAssignments = assignmentsMap[course.name] ?? [];
              final courseNotes = notesMap[course.name] ?? [];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(course.name,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(height: 10),
                      Text('Description: ${course.description}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white60)),
                      const SizedBox(height: 10),
                      Text('Duration: ${course.duration}',
                          style: TextStyle(fontSize: 14, color: lightGreen)),
                      const SizedBox(height: 5),
                      Text('Schedule: ${course.schedule}',
                          style: TextStyle(fontSize: 14, color: lightGreen)),
                      const SizedBox(height: 5),
                      Text('Instructor: ${course.instructor}',
                          style: TextStyle(fontSize: 14, color: lightGreen)),
                      const SizedBox(height: 20),
                      if (courseAssignments.isNotEmpty) ...[
                        Text('Assignments',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor)),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: courseAssignments.map((assignment) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: ListTile(
                                title: Text(assignment.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    'Due Date: ${DateFormat.yMMMd().format(assignment.dueDate)}'),
                                onTap: () {
                                  GoRouter.of(context).push(
                                      '/single-assignment',
                                      extra: assignment);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      if (courseNotes.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Text('Notes',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor)),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: courseNotes.map((note) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: ListTile(
                                title: Text(note.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text('Section: ${note.section}'),
                                onTap: () {
                                  GoRouter.of(context)
                                      .push('/single-note', extra: note);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
