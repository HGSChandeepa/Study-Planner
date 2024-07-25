import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madman/models/assignment_model.dart';
import 'package:madman/models/course_model.dart';
import 'package:madman/models/note_model.dart';
import 'package:madman/pages/single_assignment_page.dart';
import 'package:madman/pages/single_note_page.dart';
import 'package:madman/services/database/assignment_service.dart';
import 'package:madman/services/database/course_service.dart';
import 'package:madman/services/database/note_service.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  Future<Map<String, dynamic>> _fetchData() async {
    final courses = await CourseService().getCourses();
    final assignmentsMap =
        await AssignmentService().getAssignmentsWithCourseName();
    final notesMap = await NoteService().getNotesWithCourseName();

    print('notes: ${notesMap.values.last.first.imageUrl}');

    return {
      'courses': courses,
      'assignments': assignmentsMap,
      'notes': notesMap,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available.'));
          }

          final courses = snapshot.data!['courses'] as List<Course>;
          final assignmentsMap =
              snapshot.data!['assignments'] as Map<String, List<Assignment>>;
          final notesMap = snapshot.data!['notes'] as Map<String, List<Note>>;

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
                      Text(
                        course.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Description: ${course.description}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Duration: ${course.duration}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Schedule: ${course.schedule}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Instructor: ${course.instructor}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (courseAssignments.isNotEmpty) ...[
                        const Text(
                          'Assignments:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: courseAssignments.map((assignment) {
                            return ListTile(
                              title: Text(
                                assignment.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Due Date: ${DateFormat.yMMMd().format(assignment.dueDate)}',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SingleAssignmentScreen(
                                            assignment: assignment),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                      if (courseNotes.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        const Text(
                          'Notes:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: courseNotes.map((note) {
                            return ListTile(
                              title: Text(
                                note.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('Section: ${note.section}'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SingleNoteScreen(note: note),
                                  ),
                                );
                              },
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
