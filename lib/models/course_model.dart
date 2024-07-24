class Course {
  final String id;
  final String name;
  final String description;
  final String duration;
  final String schedule;
  final String instructor;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.schedule,
    required this.instructor,
  });

  // Convert a Course object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'duration': duration,
      'schedule': schedule,
      'instructor': instructor,
    };
  }

  // Convert a Map to a Course object
  factory Course.fromJson(Map<String, dynamic> map) {
    return Course(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      duration: map['duration'] ?? '',
      schedule: map['schedule'] ?? '',
      instructor: map['instructor'] ?? '',
    );
  }
}
