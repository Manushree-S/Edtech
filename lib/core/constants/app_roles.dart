/// System roles for the EdTech mobile platform.
/// Strictly supports Student, Staff (Teachers/Instructors), and Non-Technical Staff (Admins/Operations).
enum UserRole {
  student,
  staff,
  nonTechnicalStaff;

  String get id => switch (this) {
        UserRole.student => 'student',
        UserRole.staff => 'staff',
        UserRole.nonTechnicalStaff => 'non_technical_staff',
      };

  String get displayName => switch (this) {
        UserRole.student => 'Student',
        UserRole.staff => 'Staff / Faculty',
        UserRole.nonTechnicalStaff => 'Non-Technical Staff',
      };

  static UserRole? fromString(String? role) {
    if (role == null) return null;
    return switch (role.toLowerCase().trim()) {
      'student' => UserRole.student,
      'staff' || 'teacher' || 'faculty' => UserRole.staff,
      'non_technical_staff' || 'admin' || 'nontechnicalstaff' =>
        UserRole.nonTechnicalStaff,
      _ => null,
    };
  }
}
