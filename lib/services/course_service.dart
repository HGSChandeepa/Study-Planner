import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madman/models/course_model.dart';

class CourseService {
  //create the firstore collection reference
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('courses');

  Future<void> createCourse(Course course) async {
    try {
      // Convert the course object to a map
      final Map<String, dynamic> data = course.toJson();

      // Add the course to the collection
      final docRef = await courseCollection.add(data);

      // Update the course document with the generated ID
      await docRef.update({'id': docRef.id});
    } catch (error) {
      print('Error creating course: $error');
    }
  }

  //get all courses as a stream List of Course
  Stream<List<Course>> get courses {
    try {
      return courseCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Course.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (error) {
      print(error);
      return Stream.empty();
    }
  }

  //get a course by id
  Future<Course?> getCourseById(String id) async {
    try {
      final DocumentSnapshot doc = await courseCollection.doc(id).get();
      return Course.fromJson(doc.data() as Map<String, dynamic>);
    } catch (error) {
      print(error);
      return null;
    }
  }

  //delete a course
  Future<void> deleteCourse(String id) async {
    try {
      await courseCollection.doc(id).delete();
    } catch (error) {
      print(error);
    }
  }

  //update a course
  Future<void> updateCourse(Course course) async {
    try {
      final Map<String, dynamic> data = course.toJson();
      await courseCollection.doc(course.id).update(data);
    } catch (e) {
      print(e);
    }
  }
}
