import 'package:flutter/material.dart';
import 'package:madman/models/note_model.dart';

class SingleNoteScreen extends StatelessWidget {
  final Note note;

  const SingleNoteScreen({required this.note, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note: ${note.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${note.title}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(note.description),
            const SizedBox(height: 10),
            const Text(
              'Section Name:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(note.section),
            const SizedBox(height: 10),
            const Text(
              'References Books:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(note.references),
            const SizedBox(height: 10),
            // Display the image if it exists show a loading indicator till the image is loaded
            if (note.imageUrl != null)
              Image.network(note.imageUrl!)
            else
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
