import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:edtech/app.dart';
import 'package:edtech/core/constants/app_roles.dart';
import 'package:edtech/features/auth/presentation/controllers/auth_controller.dart';
import 'package:edtech/features/auth/presentation/screens/login_screen.dart';
import 'package:edtech/features/home/presentation/screens/home_screen.dart';
import 'package:edtech/features/student/presentation/screens/student_dashboard_screen.dart';
import 'package:edtech/features/staff/presentation/screens/staff_dashboard_screen.dart';
import 'package:edtech/features/admin/presentation/screens/admin_dashboard_screen.dart';

void main() {
  void setPhoneScreenSize(WidgetTester tester) {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  testWidgets('App renders HomeScreen initially and navigates to Sign In page',
      (WidgetTester tester) async {
    setPhoneScreenSize(tester);

    await tester.pumpWidget(
      const ProviderScope(
        child: EdTechApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify HomeScreen is displayed first
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Unified Education & Academic Portal'), findsOneWidget);
    expect(find.text('Go to Sign In Page'), findsOneWidget);

    // 2. Click "Go to Sign In Page" CTA
    final signInCTA = find.widgetWithText(ElevatedButton, 'Go to Sign In Page');
    await tester.ensureVisible(signInCTA);
    await tester.tap(signInCTA);
    await tester.pumpAndSettle();

    // 3. Verify LoginScreen is shown
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('EdTech Platform'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);

    // 4. Verify STRICT compliance: closed system, NO public sign-up / register button
    expect(find.textContaining('Sign Up', findRichText: true), findsNothing);
    expect(find.textContaining('Register', findRichText: true), findsNothing);
    expect(
        find.textContaining('Create Account', findRichText: true), findsNothing);
  });

  testWidgets('Quick login routes to Student Dashboard correctly from Login',
      (WidgetTester tester) async {
    setPhoneScreenSize(tester);

    await tester.pumpWidget(
      const ProviderScope(
        child: EdTechApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Go to login page
    final signInBtn = find.widgetWithText(FilledButton, 'Sign In');
    await tester.tap(signInBtn);
    await tester.pumpAndSettle();

    final studentButton = find.widgetWithText(OutlinedButton, 'Student');
    await tester.ensureVisible(studentButton);
    await tester.tap(studentButton);
    await tester.pumpAndSettle();

    // Verify redirected to Student dashboard
    expect(find.byType(StudentDashboardScreen), findsOneWidget);
    expect(find.text('EDTECH ACADEMY'), findsOneWidget);
  });

  testWidgets('Quick login routes to Staff Dashboard correctly from Login',
      (WidgetTester tester) async {
    setPhoneScreenSize(tester);

    await tester.pumpWidget(
      const ProviderScope(
        child: EdTechApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Go to login page
    final signInBtn = find.widgetWithText(FilledButton, 'Sign In');
    await tester.tap(signInBtn);
    await tester.pumpAndSettle();

    final staffButton = find.widgetWithText(OutlinedButton, 'Staff');
    await tester.ensureVisible(staffButton);
    await tester.tap(staffButton);
    await tester.pumpAndSettle();

    // Verify redirected to Staff dashboard
    expect(find.byType(StaffDashboardScreen), findsOneWidget);
    expect(find.text('Staff & Faculty Portal'), findsOneWidget);
  });

  testWidgets('Quick login routes to Admin Dashboard correctly from Login',
      (WidgetTester tester) async {
    setPhoneScreenSize(tester);

    await tester.pumpWidget(
      const ProviderScope(
        child: EdTechApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Go to login page
    final signInBtn = find.widgetWithText(FilledButton, 'Sign In');
    await tester.tap(signInBtn);
    await tester.pumpAndSettle();

    final adminButton = find.widgetWithText(OutlinedButton, 'Admin / Ops');
    await tester.ensureVisible(adminButton);
    await tester.tap(adminButton);
    await tester.pumpAndSettle();

    // Verify redirected to Admin dashboard
    expect(find.byType(AdminDashboardScreen), findsOneWidget);
    expect(find.text('Administrative Operations'), findsOneWidget);
  });

  testWidgets('First-login password change flow triggers when required',
      (WidgetTester tester) async {
    setPhoneScreenSize(tester);

    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Pre-seed user with mustChangePassword: true
    container.read(authProvider.notifier).mockLoginAs(
          UserRole.student,
          mustChangePassword: true,
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const EdTechApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Must be redirected to change password screen
    expect(find.text('Setup New Password'), findsOneWidget);
    expect(find.text('Password Update Required'), findsOneWidget);
  });
}
