import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madman/models/assignment_model.dart';

class AssignmentService {
  //create the firstore collection reference
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('courses');

  //create a new assignment in to a course
  Future<void> createAssignment(String courseId, Assignment assignment) async {
    try {
      final Map<String, dynamic> data = assignment.toJson();
      final CollectionReference assignmentCollection =
          courseCollection.doc(courseId).collection('assignments');
      DocumentReference docRef = await assignmentCollection.add(data);

      //update the assignment id with the document id
      await docRef.update({'id': docRef.id});
    } catch (error) {
      print(error);
    }
  }
}
