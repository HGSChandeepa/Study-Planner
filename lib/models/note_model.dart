import 'dart:io';

class Note {
  final String id;
  final String title;
  final String description;
  final String section;
  final String references;
  final File? imageData;
  final String? imageUrl;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.section,
    required this.references,
    this.imageData,
    this.imageUrl,
  });

  // Convert a Note instance into a Map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'section': section,
      'references': references,
      'imageData': imageData,
      'imageUrl': imageUrl,
    };
  }

  // Convert a Map into a Note instance
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      section: json['section'] ?? '',
      references: json['references'] ?? '',
      imageData: json['imageData'],
      imageUrl: json['imageUrl'],
    );
  }
}
