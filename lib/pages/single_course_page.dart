import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madman/constants/colors.dart';
import 'package:madman/models/course_model.dart';
import 'package:madman/services/database/course_service.dart';
import 'package:madman/widgets/sample_button.dart'; 

class SingleCourseScreen extends StatelessWidget {
  final Course course; 

  const SingleCourseScreen({super.key, required this.course});

  //Methode to delete the course
  void _deleteCourse(BuildContext context) async {
    //delete the course
    try {
      await CourseService().deleteCourse(course.id);
      //navigate to the courses screen
      GoRouter.of(context).go('/');
    } catch (error) {
      print('Error deleting course: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Instructor: ${course.instructor}',
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Duration: ${course.duration}',
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Schedule: ${course.schedule}',
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              course.description,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: lightGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      GoRouter.of(context).push(
                        '/add-assignment',
                        extra: course,
                      );
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Assignment',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        // description of the button
                        Text(
                          'Add a new assignment to this course and set a deadline.Also you can add a description to the assignment.',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: lightGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      GoRouter.of(context).push(
                        '/add-notes',
                        extra: course,
                      );
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Notes',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        // description of the button
                        Text(
                          'Add notes to this course to help you remember important points and topics.And you can also add images and links.',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //delete button
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'Delete Course',
              onPressed: () => _deleteCourse(context),
            ),
          ],
        ),
      ),
    );
  }
}
