import 'package:flutter_test/flutter_test.dart';
import 'package:edtech/core/constants/app_roles.dart';
import 'package:edtech/core/models/institution.dart';
import 'package:edtech/features/auth/domain/models/user_profile.dart';
import 'package:edtech/features/student/domain/models/course.dart';
import 'package:edtech/features/student/domain/models/lesson.dart';
import 'package:edtech/features/staff/domain/models/assignment.dart';
import 'package:edtech/features/attendance/domain/models/attendance_session.dart';
import 'package:edtech/features/admin/domain/models/fee_record.dart';

void main() {
  group('Firestore Models & Schema Serialization Tests', () {
    test('Institution model serializes and deserializes cleanly', () {
      final inst = Institution(
        id: 'pilot_inst_01',
        name: 'Apex Academy',
        code: 'APEX01',
        isActive: true,
        createdAt: DateTime(2026, 1, 1),
      );

      final map = inst.toMap();
      expect(map['id'], 'pilot_inst_01');
      expect(map['code'], 'APEX01');

      final reconstructed = Institution.fromMap(map);
      expect(reconstructed.id, 'pilot_inst_01');
      expect(reconstructed.name, 'Apex Academy');
      expect(reconstructed.isActive, isTrue);
    });

    test('UserProfile respects role constraints and first-login flag', () {
      final student = UserProfile(
        id: 'u_101',
        email: 'student@edtech.org',
        displayName: 'Aarav Patel',
        role: UserRole.student,
        mustChangePassword: true,
      );

      expect(student.role, UserRole.student);
      expect(student.mustChangePassword, isTrue);

      final map = student.toMap();
      expect(map['role'], 'student');

      final parsed = UserProfile.fromMap(map);
      expect(parsed.role, UserRole.student);
      expect(parsed.mustChangePassword, isTrue);
    });

    test('Course and Lesson properly store YouTube video references', () {
      const lesson = Lesson(
        id: 'les_01',
        courseId: 'c_01',
        title: 'Algebra Foundations',
        description: 'Linear equations intro',
        youtubeVideoId: 'dQw4w9WgXcQ',
        durationMinutes: 20,
      );

      final map = lesson.toMap();
      expect(map['youtubeVideoId'], 'dQw4w9WgXcQ');

      final parsed = Lesson.fromMap(map);
      expect(parsed.youtubeVideoId, 'dQw4w9WgXcQ');
      expect(parsed.durationMinutes, 20);

      const course = Course(
        id: 'c_01',
        title: 'Grade 8 Mathematics',
        description: 'Full term math curriculum',
        subject: 'Mathematics',
        gradeLevel: 'Grade 8',
        instructorId: 'inst_01',
        instructorName: 'Prof. Sharma',
        lessonCount: 1,
      );

      final courseMap = course.toMap();
      final courseParsed = Course.fromMap(courseMap);
      expect(courseParsed.subject, 'Mathematics');
      expect(courseParsed.gradeLevel, 'Grade 8');
    });

    test('Assignment and Submission perform rule-based objective scoring', () {
      const question1 = QuizQuestion(
        id: 'q1',
        prompt: 'What is 5 + 7?',
        options: ['10', '11', '12', '13'],
        correctOptionIndex: 2,
        points: 5,
      );

      const question2 = QuizQuestion(
        id: 'q2',
        prompt: 'Is 9 a prime number?',
        options: ['Yes', 'No'],
        correctOptionIndex: 1,
        points: 5,
      );

      final assignment = Assignment(
        id: 'asg_01',
        courseId: 'c_01',
        title: 'Math Quiz 1',
        instructions: 'Complete all questions',
        maxScore: 10,
        dueDate: DateTime.now().add(const Duration(days: 7)),
        isObjective: true,
        questions: [question1, question2],
      );

      expect(assignment.isObjective, isTrue);
      expect(assignment.questions.length, 2);

      // Student answers: correct for q1 (index 2), wrong for q2 (index 0)
      final submission = Submission(
        id: 'sub_01',
        assignmentId: 'asg_01',
        studentId: 'stud_01',
        studentName: 'Rahul',
        submittedAt: DateTime.now(),
        answers: {'q1': 2, 'q2': 0},
      );

      // Calculate objective rule-based score
      double calculatedScore = 0;
      for (final q in assignment.questions) {
        if (submission.answers[q.id] == q.correctOptionIndex) {
          calculatedScore += q.points;
        }
      }

      final gradedSubmission = submission.copyWith(
        score: calculatedScore,
        isGraded: true,
      );

      expect(gradedSubmission.score, 5.0);
      expect(gradedSubmission.isGraded, isTrue);
    });

    test('AttendanceSession correctly calculates percentage and absence', () {
      final session = AttendanceSession(
        id: 'att_01',
        courseId: 'c_01',
        courseName: 'Physics',
        staffId: 'staff_01',
        date: DateTime(2026, 9, 23),
        totalStudents: 40,
        presentCount: 36,
      );

      expect(session.absentCount, 4);
      expect(session.percentage, 90.0);

      final map = session.toMap();
      final parsed = AttendanceSession.fromMap(map);
      expect(parsed.totalStudents, 40);
      expect(parsed.presentCount, 36);
    });

    test('FeeRecord supports status transitions and serialization', () {
      final fee = FeeRecord(
        id: 'fee_01',
        studentId: 'stud_01',
        studentName: 'Rahul Sharma',
        title: 'Semester 1 Tuition',
        amount: 25000.0,
        dueDate: DateTime(2026, 10, 15),
        status: FeeStatus.pending,
      );

      expect(fee.status, FeeStatus.pending);

      final paidFee = fee.copyWith(
        status: FeeStatus.paid,
        paidAt: DateTime.now(),
        receiptNumber: 'REC-2026-0091',
        paymentMethod: 'Razorpay',
      );

      expect(paidFee.status, FeeStatus.paid);
      expect(paidFee.receiptNumber, 'REC-2026-0091');

      final map = paidFee.toMap();
      final parsed = FeeRecord.fromMap(map);
      expect(parsed.amount, 25000.0);
      expect(parsed.status, FeeStatus.paid);
    });
  });
}
