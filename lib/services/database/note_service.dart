import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madman/models/note_model.dart';
import 'package:madman/services/cloud_storage/store_images.dart';

class NoteService {
  //create the firstore collection reference
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('courses');

  //create a new assignment in to a course
  Future<void> createAssignment(String courseId, Note note) async {
    try {
      //store the image in the firebase storage
      String imageUrl = await StorageService()
          .uploadImage(noteImage: note.imageData, courseId: courseId);

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

      // Update the note document with the generated ID

      await docRef.update({'id': docRef.id});
    } catch (error) {
      print(error);
    }
  }
}
