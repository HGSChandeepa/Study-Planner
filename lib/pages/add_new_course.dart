import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madman/models/course_model.dart';
import 'package:madman/services/course_service.dart';
import 'package:madman/widgets/sample_button.dart';
import 'package:madman/widgets/sample_input.dart';

class AddCourseScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController =
      TextEditingController();
  final TextEditingController _courseDurationController =
      TextEditingController();
  final TextEditingController _courseScheduleController =
      TextEditingController();
  final TextEditingController _courseInstructorController =
      TextEditingController();

  AddCourseScreen({super.key});

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      // Save form
      _formKey.currentState?.save();

      // Add course to Firestore or any other storage here
      try {
        // Create a new course
        final Course course = Course(
          id: '',
          name: _courseNameController.text,
          description: _courseDescriptionController.text,
          duration: _courseDurationController.text,
          schedule: _courseScheduleController.text,
          instructor: _courseInstructorController.text,
        );

        await CourseService().createCourse(course);

        // Show success SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Course added successfully!'),
            duration: Duration(
              seconds: 1,
            ),
          ),
        );

        // Delay navigation to ensure SnackBar is displayed
        await Future.delayed(const Duration(seconds: 2));

        // Navigate to the home page
        GoRouter.of(context).go('/');
      } catch (error) {
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add course!'),
            duration: Duration(
              seconds: 1,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Add New Course',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),

                //description
                const Text(
                  'Fill in the details below to add a new course.And start managing your study planner.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                CourseInputField(
                  controller: _courseNameController,
                  labelText: 'Course Name',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a course name';
                    }
                    return null;
                  },
                ),
                CourseInputField(
                  controller: _courseDescriptionController,
                  labelText: 'Course Description',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a course description';
                    }
                    return null;
                  },
                ),
                CourseInputField(
                  controller: _courseDurationController,
                  labelText: 'Course Duration',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the course duration';
                    }
                    return null;
                  },
                ),
                CourseInputField(
                  controller: _courseScheduleController,
                  labelText: 'Course Schedule',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the course schedule';
                    }
                    return null;
                  },
                ),
                CourseInputField(
                  controller: _courseInstructorController,
                  labelText: 'Course Instructor',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the course instructor';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Add Course',
                  onPressed: () => _submitForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
