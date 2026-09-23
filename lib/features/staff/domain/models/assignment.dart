class QuizQuestion {
  final String id;
  final String prompt;
  final List<String> options;
  final int correctOptionIndex;
  final int points;

  const QuizQuestion({
    required this.id,
    required this.prompt,
    required this.options,
    required this.correctOptionIndex,
    this.points = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prompt': prompt,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
      'points': points,
    };
  }

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      id: map['id'] ?? '',
      prompt: map['prompt'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctOptionIndex: map['correctOptionIndex'] as int? ?? 0,
      points: map['points'] as int? ?? 1,
    );
  }
}

class Assignment {
  final String id;
  final String courseId;
  final String title;
  final String instructions;
  final int maxScore;
  final DateTime dueDate;
  final bool isObjective;
  final List<QuizQuestion> questions;
  final DateTime? createdAt;

  const Assignment({
    required this.id,
    required this.courseId,
    required this.title,
    required this.instructions,
    required this.maxScore,
    required this.dueDate,
    this.isObjective = true, // Defaults to rule-based objective grading
    this.questions = const [],
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'instructions': instructions,
      'maxScore': maxScore,
      'dueDate': dueDate.toIso8601String(),
      'isObjective': isObjective,
      'questions': questions.map((q) => q.toMap()).toList(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Assignment.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return Assignment(
      id: documentId ?? map['id'] ?? '',
      courseId: map['courseId'] ?? '',
      title: map['title'] ?? '',
      instructions: map['instructions'] ?? '',
      maxScore: map['maxScore'] as int? ?? 100,
      dueDate: map['dueDate'] != null
          ? DateTime.tryParse(map['dueDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
      isObjective: map['isObjective'] as bool? ?? true,
      questions: (map['questions'] as List<dynamic>?)
              ?.map((q) => QuizQuestion.fromMap(Map<String, dynamic>.from(q)))
              .toList() ??
          const [],
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString())
          : null,
    );
  }
}

class Submission {
  final String id;
  final String assignmentId;
  final String studentId;
  final String studentName;
  final DateTime submittedAt;
  final Map<String, int> answers; // questionId -> selectedOptionIndex
  final double? score;
  final bool isGraded;
  final String? feedback;
  final DateTime? gradedAt;

  const Submission({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.studentName,
    required this.submittedAt,
    this.answers = const {},
    this.score,
    this.isGraded = false,
    this.feedback,
    this.gradedAt,
  });

  Submission copyWith({
    String? id,
    String? assignmentId,
    String? studentId,
    String? studentName,
    DateTime? submittedAt,
    Map<String, int>? answers,
    double? score,
    bool? isGraded,
    String? feedback,
    DateTime? gradedAt,
  }) {
    return Submission(
      id: id ?? this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      submittedAt: submittedAt ?? this.submittedAt,
      answers: answers ?? this.answers,
      score: score ?? this.score,
      isGraded: isGraded ?? this.isGraded,
      feedback: feedback ?? this.feedback,
      gradedAt: gradedAt ?? this.gradedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'assignmentId': assignmentId,
      'studentId': studentId,
      'studentName': studentName,
      'submittedAt': submittedAt.toIso8601String(),
      'answers': answers,
      'score': score,
      'isGraded': isGraded,
      'feedback': feedback,
      'gradedAt': gradedAt?.toIso8601String(),
    };
  }

  factory Submission.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return Submission(
      id: documentId ?? map['id'] ?? '',
      assignmentId: map['assignmentId'] ?? '',
      studentId: map['studentId'] ?? '',
      studentName: map['studentName'] ?? '',
      submittedAt: map['submittedAt'] != null
          ? DateTime.tryParse(map['submittedAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      answers: Map<String, int>.from(map['answers'] ?? {}),
      score: (map['score'] as num?)?.toDouble(),
      isGraded: map['isGraded'] as bool? ?? false,
      feedback: map['feedback'] as String?,
      gradedAt: map['gradedAt'] != null
          ? DateTime.tryParse(map['gradedAt'].toString())
          : null,
    );
  }
}
