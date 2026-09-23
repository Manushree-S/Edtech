import '../../../../core/constants/app_roles.dart';

class UserProfile {
  final String id;
  final String email;
  final String displayName;
  final UserRole role;
  final bool mustChangePassword;
  final String institutionId;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;

  const UserProfile({
    required this.id,
    required this.email,
    required this.displayName,
    required this.role,
    this.mustChangePassword = false,
    this.institutionId = 'pilot_inst_01',
    this.createdAt,
    this.lastLoginAt,
  });

  UserProfile copyWith({
    String? id,
    String? email,
    String? displayName,
    UserRole? role,
    bool? mustChangePassword,
    String? institutionId,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      mustChangePassword: mustChangePassword ?? this.mustChangePassword,
      institutionId: institutionId ?? this.institutionId,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'role': role.id,
      'mustChangePassword': mustChangePassword,
      'institutionId': institutionId,
      'createdAt': createdAt?.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return UserProfile(
      id: documentId ?? map['id'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      role: UserRole.fromString(map['role'] as String?) ?? UserRole.student,
      mustChangePassword: map['mustChangePassword'] as bool? ?? false,
      institutionId: map['institutionId'] ?? 'pilot_inst_01',
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString())
          : null,
      lastLoginAt: map['lastLoginAt'] != null
          ? DateTime.tryParse(map['lastLoginAt'].toString())
          : null,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          role == other.role &&
          mustChangePassword == other.mustChangePassword &&
          institutionId == other.institutionId;

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      role.hashCode ^
      mustChangePassword.hashCode ^
      institutionId.hashCode;
}
