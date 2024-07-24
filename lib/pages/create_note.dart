import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madman/models/note_model.dart';
import 'package:madman/services/database/note_service.dart';
import 'dart:io';

import 'package:madman/widgets/sample_button.dart';
import 'package:madman/widgets/sample_input.dart';

class CreateNotePage extends StatefulWidget {
  final String courseId;
  const CreateNotePage({
    super.key,
    required this.courseId,
  });

  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage; // Holds the selected image
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _referencesController = TextEditingController();

  // Method to pick image from gallery
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  // Method to submit the form
  void _submitForm() async {
    // Get the form values
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final String section = _sectionController.text;
    final String references = _referencesController.text;

    // Create a new note object
    try {
      Note note = Note(
        id: '',
        title: title,
        description: description,
        section: section,
        references: references,
        imageData: _selectedImage != null ? File(_selectedImage!.path) : null,
      );

      // Call the createAssignment method from the NoteService
      await NoteService().createAssignment(
        widget.courseId,
        note,
      );

      // Show success SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note added successfully!'),
          duration: Duration(
            seconds: 1,
          ),
        ),
      );

      // Delay navigation to ensure SnackBar is displayed
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to the home page
      GoRouter.of(context).go('/');
    } catch (e) {
      print('Error creating note: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add note!'),
          duration: Duration(
            seconds: 1,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _sectionController.dispose();
    _referencesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Note For Your Course',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),

              //description
              const Text(
                'Fill in the details below to add a new note. And start managing your study planner.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              CourseInputField(
                controller: _titleController,
                labelText: 'Note Title',
              ),
              CourseInputField(
                controller: _descriptionController,
                labelText: 'Description',
              ),
              CourseInputField(
                controller: _sectionController,
                labelText: 'Section Name',
              ),
              CourseInputField(
                controller: _referencesController,
                labelText: 'Reference Books',
              ),

              const Divider(),
              const Text(
                'Upload Note Image , for better understanding and quick revision',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              // Button to upload image
              CustomElevatedButton(
                onPressed: _pickImage,
                text: 'Upload Note Image',
              ),
              const SizedBox(height: 20),
              // Display selected image
              _selectedImage != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Image:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(_selectedImage!.path),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )
                  : const Text(
                      'No image selected.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
              const SizedBox(height: 20),
              // Submit button
              CustomElevatedButton(
                onPressed: _submitForm,
                text: 'Submit Note',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
