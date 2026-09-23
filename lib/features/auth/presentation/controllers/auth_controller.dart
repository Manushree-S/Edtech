import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_roles.dart';
import '../../domain/models/user_profile.dart';

class AuthState {
  final bool isLoading;
  final UserProfile? user;
  final String? errorMessage;

  const AuthState({
    this.isLoading = false,
    this.user,
    this.errorMessage,
  });

  bool get isAuthenticated => user != null;
  UserRole? get role => user?.role;
  bool get mustChangePassword => user?.mustChangePassword ?? false;

  AuthState copyWith({
    bool? isLoading,
    UserProfile? user,
    String? errorMessage,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: clearUser ? null : (user ?? this.user),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  /// Mock login helper for testing / pre-Firebase testing
  void mockLoginAs(
    UserRole role, {
    bool mustChangePassword = false,
  }) {
    final mockUser = UserProfile(
      id: 'mock_${role.id}_001',
      email: '${role.id}@edtech.org',
      displayName: '${role.displayName} Demo',
      role: role,
      mustChangePassword: mustChangePassword,
      lastLoginAt: DateTime.now(),
    );

    state = state.copyWith(isLoading: false, user: mockUser);
  }

  /// Sign in using admin-provisioned email & password
  Future<bool> signInWithEmailPassword(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final trimmedEmail = email.trim().toLowerCase();
      UserRole role = UserRole.student;
      if (trimmedEmail.contains('staff') || trimmedEmail.contains('faculty')) {
        role = UserRole.staff;
      } else if (trimmedEmail.contains('admin') ||
          trimmedEmail.contains('operations')) {
        role = UserRole.nonTechnicalStaff;
      }

      final profile = UserProfile(
        id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
        email: trimmedEmail,
        displayName: trimmedEmail.split('@').first.toUpperCase(),
        role: role,
        mustChangePassword: password == 'TempPass123!',
        lastLoginAt: DateTime.now(),
      );

      state = state.copyWith(isLoading: false, user: profile);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  /// First-login mandatory password change
  Future<bool> updatePassword(String newPassword) async {
    if (state.user == null) return false;
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final updatedUser = state.user!.copyWith(mustChangePassword: false);
      state = state.copyWith(isLoading: false, user: updatedUser);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    state = state.copyWith(clearUser: true, clearError: true);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
