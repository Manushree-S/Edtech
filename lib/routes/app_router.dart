import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_roles.dart';
import '../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../features/auth/presentation/controllers/auth_controller.dart';
import '../features/auth/presentation/screens/change_password_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/staff/presentation/screens/staff_dashboard_screen.dart';
import '../features/student/presentation/screens/student_dashboard_screen.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(
      authProvider,
      (_, _) => notifyListeners(),
    );
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authProvider);
    final isAuthenticated = authState.isAuthenticated;
    final isHome = state.matchedLocation == '/';
    final isLoggingIn = state.matchedLocation == '/login';
    final isChangingPassword = state.matchedLocation == '/change-password';

    // 1. Unauthenticated users can view Home ('/') or Login ('/login')
    if (!isAuthenticated) {
      if (isHome || isLoggingIn) return null;
      return '/login';
    }

    final user = authState.user!;

    // 2. Mandatory first-login password change flow
    if (user.mustChangePassword) {
      return isChangingPassword ? null : '/change-password';
    }

    // 3. User is authenticated & password is set. If they visit login or change-password,
    // route them to their role portal.
    final roleTarget = switch (user.role) {
      UserRole.student => '/student',
      UserRole.staff => '/staff',
      UserRole.nonTechnicalStaff => '/admin',
    };

    if (isLoggingIn || isChangingPassword) {
      return roleTarget;
    }

    // 4. Role boundary guard (prevent student from opening /staff or /admin, etc.)
    if (state.matchedLocation.startsWith('/student') &&
        user.role != UserRole.student) {
      return roleTarget;
    }
    if (state.matchedLocation.startsWith('/staff') &&
        user.role != UserRole.staff) {
      return roleTarget;
    }
    if (state.matchedLocation.startsWith('/admin') &&
        user.role != UserRole.nonTechnicalStaff) {
      return roleTarget;
    }

    return null;
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

final goRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: '/student',
        builder: (context, state) => const StudentDashboardScreen(),
      ),
      GoRoute(
        path: '/staff',
        builder: (context, state) => const StaffDashboardScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
    ],
  );
});
