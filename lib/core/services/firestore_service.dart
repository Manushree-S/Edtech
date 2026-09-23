import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

class FirestoreService {
  final FirebaseFirestore? _firestore;
  final String institutionId;

  FirestoreService({
    FirebaseFirestore? firestore,
    this.institutionId = 'pilot_inst_01',
  }) : _firestore = firestore ??
            (FirebaseService.isInitialized ? FirebaseFirestore.instance : null);

  bool get isLive => _firestore != null && FirebaseService.isInitialized;

  // Collection references
  CollectionReference<Map<String, dynamic>>? get usersRef => isLive
      ? _firestore!
          .collection('institutions')
          .doc(institutionId)
          .collection('users')
      : null;

  CollectionReference<Map<String, dynamic>>? get coursesRef => isLive
      ? _firestore!
          .collection('institutions')
          .doc(institutionId)
          .collection('courses')
      : null;

  CollectionReference<Map<String, dynamic>>? lessonsRef(String courseId) =>
      isLive ? coursesRef?.doc(courseId).collection('lessons') : null;

  CollectionReference<Map<String, dynamic>>? get assignmentsRef => isLive
      ? _firestore!
          .collection('institutions')
          .doc(institutionId)
          .collection('assignments')
      : null;

  CollectionReference<Map<String, dynamic>>? submissionsRef(
          String assignmentId) =>
      isLive ? assignmentsRef?.doc(assignmentId).collection('submissions') : null;

  CollectionReference<Map<String, dynamic>>? get attendanceRef => isLive
      ? _firestore!
          .collection('institutions')
          .doc(institutionId)
          .collection('attendance_sessions')
      : null;

  CollectionReference<Map<String, dynamic>>? attendanceRecordsRef(
          String sessionId) =>
      isLive ? attendanceRef?.doc(sessionId).collection('records') : null;

  CollectionReference<Map<String, dynamic>>? get feesRef => isLive
      ? _firestore!
          .collection('institutions')
          .doc(institutionId)
          .collection('fees')
      : null;
}
