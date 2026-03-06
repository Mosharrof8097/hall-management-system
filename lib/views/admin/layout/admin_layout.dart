import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../providers/auth_provider.dart';

class AdminLayout extends StatefulWidget {
  final Widget child;

  const AdminLayout({super.key, required this.child});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  bool isSidebarExpanded = true;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1100;
    final isTablet = MediaQuery.of(context).size.width >= 700 && !isDesktop;
    
    // Auto-collapse sidebar on smaller screens
    if (!isDesktop && isSidebarExpanded) {
      isSidebarExpanded = false;
    } else if (isDesktop && !isSidebarExpanded) {
      isSidebarExpanded = true;
    }

    return Scaffold(
      appBar: !isDesktop
          ? AppBar(
              title: const Text('Admin Dashboard', style: TextStyle(color: Colors.white)),
              backgroundColor: const Color(0xFF1E3A8A),
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
              color: const Color(0xFF1E3A8A), // Dark blue sidebar
              child: _buildSidebar(context),
            ),
          
          Expanded(
            child: Column(
              children: [
                if (isDesktop) _buildTopNav(context),
                Expanded(
                  child: Container(
                    color: Colors.grey[100], // Light background for content
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
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              setState(() {
                isSidebarExpanded = !isSidebarExpanded;
              });
            },
          ),
          const Spacer(),
          const Text('Welcome, Admin', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 20),
          const CircleAvatar(
            backgroundColor: AppColors.admin,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    final currentRoute = GoRouterState.of(context).matchedLocation;

    return Column(
      children: [
        if (!isDesktop(context)) const SizedBox(height: 50),
        if (isDesktop(context))
          Container(
            height: 60,
            alignment: isSidebarExpanded ? Alignment.centerLeft : Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: isSidebarExpanded
                ? const Text(
                    'MEC Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Icon(Icons.shield, color: Colors.white),
          ),
        const Divider(color: Colors.white24),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildNavItem(context, icon: Icons.dashboard,       title: 'Dashboard',    route: AppRoutes.adminDashboard, isActive: currentRoute == AppRoutes.adminDashboard),
                _buildNavItem(context, icon: Icons.people,          title: 'Students',     route: AppRoutes.adminStudents,  isActive: currentRoute.startsWith(AppRoutes.adminStudents)),
                _buildNavItem(context, icon: Icons.manage_accounts, title: 'Managers',     route: AppRoutes.adminManagers,  isActive: currentRoute.startsWith(AppRoutes.adminManagers)),
                _buildNavItem(context, icon: Icons.meeting_room,    title: 'Rooms',        route: AppRoutes.adminRooms,     isActive: currentRoute.startsWith(AppRoutes.adminRooms)),
                _buildNavItem(context, icon: Icons.receipt_long,    title: 'Billing',      route: AppRoutes.adminBilling,   isActive: currentRoute.startsWith(AppRoutes.adminBilling)),
                _buildNavItem(context, icon: Icons.campaign,        title: 'Notices',      route: AppRoutes.adminNotices,   isActive: currentRoute.startsWith(AppRoutes.adminNotices)),
                _buildNavItem(context, icon: Icons.event_seat,      title: 'Applications', route: AppRoutes.adminVacancy,   isActive: currentRoute.startsWith(AppRoutes.adminVacancy)),
                _buildNavItem(context, icon: Icons.bar_chart,       title: 'Reports',      route: AppRoutes.adminReports,   isActive: currentRoute.startsWith(AppRoutes.adminReports)),
                _buildNavItem(context, icon: Icons.settings,        title: 'Settings',     route: AppRoutes.adminSettings,  isActive: currentRoute.startsWith(AppRoutes.adminSettings)),
              ],
            ),
          ),
        const Divider(color: Colors.white24),
        _buildNavItem(
          context,
          icon: Icons.logout,
          title: 'Logout',
          route: '',
          isActive: false,
          onTap: () async {
            await context.read<AuthProvider>().logout();
            if (context.mounted) {
              context.go(AppRoutes.login);
            }
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    required bool isActive,
    VoidCallback? onTap,
  }) {
    final bool showText = isSidebarExpanded || !isDesktop(context);

    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? Colors.white : Colors.white70,
      ),
      title: showText
          ? Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white70,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            )
          : null,
      selected: isActive,
      selectedTileColor: Colors.white.withValues(alpha: 0.1),
      onTap: onTap ?? () {
        if (!isDesktop(context)) {
          Navigator.pop(context); // Close drawer
        }
        context.go(route);
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: showText ? 20 : 0,
      ),
      hoverColor: Colors.white.withValues(alpha: 0.05),
    );
  }

  bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;
}
