import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madman/models/course_model.dart';
import 'package:madman/pages/add_new_assignment.dart';
import 'package:madman/pages/add_new_course.dart';
import 'package:madman/pages/create_note.dart';
import 'package:madman/pages/home_page.dart';
import 'package:madman/pages/single_course_page.dart';

class RouterClass {
  final router = GoRouter(
    initialLocation: "/",
    errorPageBuilder: (context, state) {
      return const MaterialPage<dynamic>(
        child: Scaffold(
          body: Center(
            child: Text("this page is not found!!"),
          ),
        ),
      );
    },
    routes: [
      // Home Page
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return HomePage();
        },
      ),

      //add course
      GoRoute(
        name: "add Course",
        path: "/add-course",
        builder: (context, state) {
          return AddCourseScreen();
        },
      ),

      //add assignment
      GoRoute(
        name: "add Assignment",
        path: "/add-assignment",
        builder: (context, state) {
          final Course course = state.extra as Course;

          return AddAssignmentScreen(
            courseId: course.id,
          );
        },
      ),

      //add Note
      GoRoute(
        name: "add Note",
        path: "/add-notes",
        builder: (context, state) {
          final Course course = state.extra as Course;

          return CreateNotePage(
            courseId: course.id,
          );
        },
      ),

      //Single Course
      GoRoute(
        path: '/single-course',
        builder: (context, state) {
          final Course course = state.extra as Course;
          return SingleCourseScreen(course: course);
        },
      ),

      // //single assignment
      // GoRoute(
      //   path: '/single-assignment',
      //   builder: (context, state) {
      //     final Course course = state.extra as Course;
      //     return S(course: course);
      //   },
      // ),

      // //single note
    ],
  );
}
