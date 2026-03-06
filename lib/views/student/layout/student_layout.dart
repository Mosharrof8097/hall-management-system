import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../providers/auth_provider.dart';

class StudentLayout extends StatefulWidget {
  final Widget child;
  const StudentLayout({super.key, required this.child});

  @override
  State<StudentLayout> createState() => _StudentLayoutState();
}

class _StudentLayoutState extends State<StudentLayout> {
  bool isSidebarExpanded = true;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1100;

    if (!isDesktop && isSidebarExpanded) {
      isSidebarExpanded = false;
    } else if (isDesktop && !isSidebarExpanded) {
      isSidebarExpanded = true;
    }

    return Scaffold(
      appBar: !isDesktop
          ? AppBar(
              title: const Text('Student Portal', style: TextStyle(color: Colors.white)),
              backgroundColor: AppColors.studentDark,
              iconTheme: const IconThemeData(color: Colors.white),
            )
          : null,
      drawer: !isDesktop ? _buildSidebar(context) : null,
      body: Row(
        children: [
          if (isDesktop)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSidebarExpanded ? 250 : 80,
              decoration: const BoxDecoration(gradient: AppColors.studentGradient),
              child: _buildSidebar(context),
            ),
          Expanded(
            child: Column(
              children: [
                if (isDesktop) _buildTopNav(context),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF5F5FF),
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNav(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Row(children: [
        IconButton(icon: const Icon(Icons.menu), onPressed: () => setState(() => isSidebarExpanded = !isSidebarExpanded)),
        const Spacer(),
        const Text('Welcome, Student 👋', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 16),
        const CircleAvatar(backgroundColor: AppColors.student, child: Icon(Icons.person, color: Colors.white)),
      ]),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    final currentRoute = GoRouterState.of(context).matchedLocation;
    final isDesktop    = MediaQuery.of(context).size.width >= 1100;
    final showText     = isSidebarExpanded || !isDesktop;

    return Column(children: [
      if (!isDesktop) const SizedBox(height: 50),
      if (isDesktop)
        Container(
          height: 60,
          alignment: showText ? Alignment.centerLeft : Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: showText
              ? const Text('My Hall Portal', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
              : const Icon(Icons.school, color: Colors.white),
        ),
      const Divider(color: Colors.white24),
      Expanded(
        child: ListView(padding: EdgeInsets.zero, children: [
          _navItem(context, Icons.dashboard,         'Dashboard',   AppRoutes.studentDashboard, currentRoute == AppRoutes.studentDashboard),
          _navItem(context, Icons.restaurant,        'Meal Status', AppRoutes.studentMeal,      currentRoute.startsWith(AppRoutes.studentMeal)),
          _navItem(context, Icons.receipt_long,      'My Dues',     AppRoutes.studentDues,      currentRoute.startsWith(AppRoutes.studentDues)),
          _navItem(context, Icons.campaign,          'Notices',     AppRoutes.studentNotices,   currentRoute.startsWith(AppRoutes.studentNotices)),
          _navItem(context, Icons.feedback_outlined, 'Complaints',  AppRoutes.studentComplaints, currentRoute.startsWith(AppRoutes.studentComplaints)),
        ]),
      ),
      const Divider(color: Colors.white24),
      _navItem(context, Icons.logout, 'Logout', '', false, onTap: () async {
        await context.read<AuthProvider>().logout();
        if (context.mounted) context.go(AppRoutes.login);
      }),
      const SizedBox(height: 20),
    ]);
  }

  Widget _navItem(BuildContext context, IconData icon, String title, String route, bool isActive, {VoidCallback? onTap}) {
    final isDesktop = MediaQuery.of(context).size.width >= 1100;
    final showText  = isSidebarExpanded || !isDesktop;
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.white : Colors.white70),
      title: showText ? Text(title, style: TextStyle(color: isActive ? Colors.white : Colors.white70, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)) : null,
      selected: isActive,
      selectedTileColor: Colors.white.withValues(alpha: 0.12),
      hoverColor: Colors.white.withValues(alpha: 0.06),
      contentPadding: EdgeInsets.symmetric(horizontal: showText ? 20 : 0),
      onTap: onTap ?? () {
        if (!isDesktop) Navigator.pop(context);
        context.go(route);
      },
    );
  }
}
