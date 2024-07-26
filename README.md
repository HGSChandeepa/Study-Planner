# Study Planner App - DP Education (App 12)

## Description

The Study Planner App is a comprehensive tool designed to help students and professionals manage their courses, assignments, and notes effectively. The app allows users to view courses, track assignments, and access notes with notifications for overdue tasks.

## Features

- View and manage courses.
- Track assignments with due dates.
- Access and organize course notes.
- Receive notifications for overdue assignments.
- Real-time updates for assignments and notifications.

## Technologies Used

- Flutter
- Firebase Firestore
- Firebase Authentication
- Firebase Cloud Storage
- Firebase Cloud Functions
- GoRouter for navigation

## Setup Instructions

### Prerequisites

- Flutter installed on your machine.
- A Firebase project set up with Firestore, Authentication, and Cloud Storage.

### Installation

1. **Clone the repository:**

   ```bash
   https://github.com/HGSChandeepa/Study-Planner
   ```

2. **Navigate to the project directory:**

   ```bash
   cd Study-Planner
   ```

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Set up Firebase:**
   
   - Follow the instructions on the Firebase website to add your `google-services.json` (for Android) and/or `GoogleService-Info.plist` (for iOS) to the appropriate directories.
   - Update your `firebase_options.dart` with the configuration from your Firebase project.

5. **Run the app:**

   ```bash
   flutter run
   ```

## Usage

- **Courses Screen:** View and manage all courses. Tap on a course to see its assignments and notes.
- **Assignments Screen:** View all assignments, with the ability to see due dates and track overdue assignments.
- **Notes Screen:** View all notes associated with each course.

## Contributing

If you would like to contribute to the project:

1. **Fork the repository.**
2. **Create a new branch:**

   ```bash
   git checkout -b feature/your-feature
   ```

3. **Commit your changes:**

   ```bash
   git add .
   git commit -m 'Add new feature'
   ```

4. **Push to the branch:**

   ```bash
   git push origin feature/your-feature
   ```

5. **Create a pull request on GitHub.**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
