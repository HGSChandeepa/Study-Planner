import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madman/pages/add_new_assignment.dart';
import 'package:madman/pages/add_new_course.dart';
import 'package:madman/pages/home_page.dart';

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
          return AddAssignmentScreen();
        },
      ),
    ],
  );
}
