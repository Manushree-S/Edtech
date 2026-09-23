import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class StudentDashboardScreen extends ConsumerWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final studentName = user?.displayName.isNotEmpty == true
        ? user!.displayName.toUpperCase()
        : 'MANUSHREE S';
    final studentEmail = user?.email.isNotEmpty == true
        ? user!.email
        : 'smanushree08@gmail.com';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Header Banner
                    _CurvedHeader(
                      studentName: studentName,
                      studentEmail: studentEmail,
                      onSignOut: () =>
                          ref.read(authProvider.notifier).signOut(),
                    ),

                    // Grid of 12 Student Learning Tiles (3 per row)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.86,
                        children: [
                          _DashboardTile(
                            icon: Icons.calendar_month_outlined,
                            iconColor: const Color(0xFF00B4D8),
                            title: 'Academic\nCalendar',
                            onTap: () {},
                          ),
                          _DashboardTile(
                            icon: Icons.access_time_rounded,
                            iconColor: const Color(0xFF3A86FF),
                            title: 'Time Table',
                            onTap: () {},
                          ),
                          _DashboardTile(
                            icon: Icons.fact_check_outlined,
                            iconColor: const Color(0xFF7209B7),
                            title: 'Attendance',
                            onTap: () {},
                          ),
                          _DashboardTile(
                            icon: Icons.menu_book_rounded,
                            iconColor: const Color(0xFFE63946),
                            title: 'Courses',
                            onTap: () {},
                          ),
                          _DashboardTile(
                            icon: Icons.assignment_outlined,
                            iconColor: const Color(0xFF0077B6),
                            title: 'Assignments',
                            onTap: () {},
                          ),
                          _DashboardTile(
                            icon: Icons.campaign_outlined,
                            iconColor: const Color(0xFFE76F51),
                            title: 'Announcements',
                            onTap: () {},
                          ),
                          _DashboardTile(
                            icon: Icons.military_tech_outlined,
                            iconColor: const Color(0xFF9D4EDD),
                            title: 'Quizzes',
                            onTap: () {},
                          ),
                          _DashboardTile(
                            icon: Icons.account_balance_wallet_outlined,
                            iconColor: const Color(0xFF2A9D8F),
                            title: 'Fees',
                            onTap: () {},
                          ),
                          _DashboardTile(
                            icon: Icons.notifications_none_rounded,
                            iconColor: const Color(0xFF4361EE),
                            title: 'Notifications',
                            onTap: () {},
                          ),
                          _DashboardTile(
                            icon: Icons.insights_rounded,
                            iconColor: const Color(0xFFF28482),
                            title: 'Progress\nReport',
                            onTap: () {},
                          ),
                          _DashboardTile(
                            icon: Icons.videocam_outlined,
                            iconColor: const Color(0xFF0096C7),
                            title: 'Live Classes',
                            onTap: () {},
                          ),
                          _DashboardTile(
                            icon: Icons.chat_bubble_outline_rounded,
                            iconColor: const Color(0xFF588157),
                            title: 'Feedback',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    const Text(
                      'App Version : 1.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8E8E93),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            const _AndroidBottomNavBar(),
          ],
        ),
      ),
    );
  }
}

class _CurvedHeader extends StatelessWidget {
  final String studentName;
  final String studentEmail;
  final VoidCallback onSignOut;

  const _CurvedHeader({
    required this.studentName,
    required this.studentEmail,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _HeaderWaveClipper(),
      child: Container(
        color: const Color(0xFF0F0F14), // Dark Navy/Black
        padding: const EdgeInsets.only(
          top: 48,
          left: 20,
          right: 20,
          bottom: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: App Name & Profile Photo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'EDTECH ACADEMY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                GestureDetector(
                  onTap: onSignOut,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFF4C430),
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFF262635),
                      child: Icon(
                        Icons.person,
                        color: Colors.white70,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Student Name (Bold Gold)
            Text(
              studentName,
              style: const TextStyle(
                color: Color(0xFFF4C430), // Gold Accent
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 4),

            // Contact Row
            Text(
              '6360456243  |  $studentEmail',
              style: const TextStyle(
                color: Color(0xFFA0A0AB),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),

            // Academic Detail Row with Dividers
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StudentDetailChip(label: 'Grade', value: '8'),
                  _VerticalDivider(),
                  _StudentDetailChip(label: 'Sec', value: 'A'),
                  _VerticalDivider(),
                  _StudentDetailChip(label: 'Roll No', value: '24'),
                  _VerticalDivider(),
                  _StudentDetailChip(label: 'Batch', value: '2026'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudentDetailChip extends StatelessWidget {
  final String label;
  final String value;

  const _StudentDetailChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8E8E93),
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 22,
      color: Colors.white24,
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  const _DashboardTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEBEBF0), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withAlpha(18),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF1C1C1E),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AndroidBottomNavBar extends StatelessWidget {
  const _AndroidBottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E5EA), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Color(0xFF8E8E93),
              size: 22,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.home_outlined,
              color: Color(0xFF8E8E93),
              size: 24,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF8E8E93),
              size: 22,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 24);

    final controlPoint = Offset(size.width / 2, size.height);
    final endPoint = Offset(size.width, size.height - 24);

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
