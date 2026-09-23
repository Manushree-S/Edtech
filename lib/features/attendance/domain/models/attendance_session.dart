class AttendanceRecord {
  final String id;
  final String sessionId;
  final String studentId;
  final String studentName;
  final DateTime date;
  final bool isPresent;
  final String? notes;

  const AttendanceRecord({
    required this.id,
    required this.sessionId,
    required this.studentId,
    required this.studentName,
    required this.date,
    required this.isPresent,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionId,
      'studentId': studentId,
      'studentName': studentName,
      'date': date.toIso8601String(),
      'isPresent': isPresent,
      'notes': notes,
    };
  }

  factory AttendanceRecord.fromMap(Map<String, dynamic> map,
      {String? documentId}) {
    return AttendanceRecord(
      id: documentId ?? map['id'] ?? '',
      sessionId: map['sessionId'] ?? '',
      studentId: map['studentId'] ?? '',
      studentName: map['studentName'] ?? '',
      date: map['date'] != null
          ? DateTime.tryParse(map['date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      isPresent: map['isPresent'] as bool? ?? false,
      notes: map['notes'] as String?,
    );
  }
}

class AttendanceSession {
  final String id;
  final String courseId;
  final String courseName;
  final String staffId;
  final DateTime date;
  final int totalStudents;
  final int presentCount;
  final List<AttendanceRecord> records;

  const AttendanceSession({
    required this.id,
    required this.courseId,
    required this.courseName,
    required this.staffId,
    required this.date,
    this.totalStudents = 0,
    this.presentCount = 0,
    this.records = const [],
  });

  int get absentCount => totalStudents - presentCount;
  double get percentage =>
      totalStudents > 0 ? (presentCount / totalStudents) * 100 : 0.0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'courseName': courseName,
      'staffId': staffId,
      'date': date.toIso8601String(),
      'totalStudents': totalStudents,
      'presentCount': presentCount,
    };
  }

  factory AttendanceSession.fromMap(Map<String, dynamic> map,
      {String? documentId}) {
    return AttendanceSession(
      id: documentId ?? map['id'] ?? '',
      courseId: map['courseId'] ?? '',
      courseName: map['courseName'] ?? '',
      staffId: map['staffId'] ?? '',
      date: map['date'] != null
          ? DateTime.tryParse(map['date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      totalStudents: map['totalStudents'] as int? ?? 0,
      presentCount: map['presentCount'] as int? ?? 0,
    );
  }
}
