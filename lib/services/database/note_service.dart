import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madman/models/note_model.dart';
import 'package:madman/services/cloud_storage/store_images.dart';

class NoteService {
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('courses');

  Future<void> createNote(String courseId, Note note) async {
    try {
      // Store the image in Firebase Storage if it exists
      String? imageUrl;
      if (note.imageData != null) {
        imageUrl = await StorageService()
            .uploadImage(noteImage: note.imageData, courseId: courseId);
      }

      // Create a new note object
      final Map<String, dynamic> data = {
        'title': note.title,
        'description': note.description,
        'section': note.section,
        'references': note.references,
        'imageUrl': imageUrl,
      };

      // Add the note to the collection
      final docRef =
          await courseCollection.doc(courseId).collection('notes').add(data);
      await docRef.update({'id': docRef.id});
    } catch (error) {
      print(error);
    }
  }

  Stream<List<Note>> getNotes(String courseId) {
    try {
      final CollectionReference notesCollection =
          courseCollection.doc(courseId).collection('notes');
      return notesCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Note.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (error) {
      print(error);
      return Stream.empty();
    }
  }

  Future<Map<String, List<Note>>> getNotesWithCourseName() async {
    try {
      final QuerySnapshot snapshot = await courseCollection.get();
      final Map<String, List<Note>> notesMap = {};

      for (final doc in snapshot.docs) {
        final String courseId = doc.id;
        final List<Note> notes = await getNotes(courseId).first;
        notesMap[doc['name']] = notes;
      }

      return notesMap;
    } catch (error) {
      print(error);
      return {};
    }
  }
}
