import 'lesson.dart';

class Course {
  final String id;
  final String title;
  final String description;
  final String subject;
  final String gradeLevel;
  final String instructorId;
  final String instructorName;
  final String? thumbnailUrl;
  final int lessonCount;
  final List<Lesson> lessons;
  final DateTime? createdAt;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.gradeLevel,
    required this.instructorId,
    required this.instructorName,
    this.thumbnailUrl,
    this.lessonCount = 0,
    this.lessons = const [],
    this.createdAt,
  });

  Course copyWith({
    String? id,
    String? title,
    String? description,
    String? subject,
    String? gradeLevel,
    String? instructorId,
    String? instructorName,
    String? thumbnailUrl,
    int? lessonCount,
    List<Lesson>? lessons,
    DateTime? createdAt,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      subject: subject ?? this.subject,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      instructorId: instructorId ?? this.instructorId,
      instructorName: instructorName ?? this.instructorName,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      lessonCount: lessonCount ?? this.lessonCount,
      lessons: lessons ?? this.lessons,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'subject': subject,
      'gradeLevel': gradeLevel,
      'instructorId': instructorId,
      'instructorName': instructorName,
      'thumbnailUrl': thumbnailUrl,
      'lessonCount': lessonCount,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Course.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return Course(
      id: documentId ?? map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      subject: map['subject'] ?? '',
      gradeLevel: map['gradeLevel'] ?? '',
      instructorId: map['instructorId'] ?? '',
      instructorName: map['instructorName'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] as String?,
      lessonCount: map['lessonCount'] as int? ?? 0,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString())
          : null,
    );
  }
}
