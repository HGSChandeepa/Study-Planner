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

  //get all assignments in a course and return as a stream List of Assignment
  Stream<List<Assignment>> getAssignments(String courseId) {
    try {
      final CollectionReference assignmentCollection =
          courseCollection.doc(courseId).collection('assignments');
      return assignmentCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) =>
                Assignment.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (error) {
      print(error);
      return Stream.empty();
    }
  }

  //get an assignment by id
  Future<Assignment?> getAssignmentById(
      String courseId, String assignmentId) async {
    try {
      final DocumentSnapshot doc = await courseCollection
          .doc(courseId)
          .collection('assignments')
          .doc(assignmentId)
          .get();
      return Assignment.fromJson(doc.data() as Map<String, dynamic>);
    } catch (error) {
      print(error);
      return null;
    }
  }

  //get all assignments with the course name
  Future<Map<String, List<Assignment>>> getAssignmentsWithCourseName() async {
    try {
      final QuerySnapshot snapshot = await courseCollection.get();
      final Map assignmentsMap = <String, List<Assignment>>{};
      for (final doc in snapshot.docs) {
        //current course id
        final String courseId = doc.id;
        //all the assignments inside the course
        final List<Assignment> assignments = await getAssignments(courseId)
            .first; //get the first value of the stream

        //create a new key value pair with the course name and the list of assignments
        assignmentsMap[doc['name']] = assignments;
      }

      return assignmentsMap as Map<String, List<Assignment>>;
    } catch (error) {
      print(error);
      return {};
    }
  }
}
