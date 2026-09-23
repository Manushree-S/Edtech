class Lesson {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final String youtubeVideoId;
  final int durationMinutes;
  final int orderIndex;
  final bool isFreePreview;

  const Lesson({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.youtubeVideoId,
    this.durationMinutes = 15,
    this.orderIndex = 0,
    this.isFreePreview = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'youtubeVideoId': youtubeVideoId,
      'durationMinutes': durationMinutes,
      'orderIndex': orderIndex,
      'isFreePreview': isFreePreview,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return Lesson(
      id: documentId ?? map['id'] ?? '',
      courseId: map['courseId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      youtubeVideoId: map['youtubeVideoId'] ?? '',
      durationMinutes: map['durationMinutes'] as int? ?? 15,
      orderIndex: map['orderIndex'] as int? ?? 0,
      isFreePreview: map['isFreePreview'] as bool? ?? false,
    );
  }
}
