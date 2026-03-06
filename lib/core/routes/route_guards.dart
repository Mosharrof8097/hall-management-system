import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hall_management/views/admin/dashboard/admin_dashboard_page.dart';
import 'package:hall_management/views/admin/layout/admin_layout.dart';
import 'package:hall_management/views/admin/managers/admin_managers_page.dart';
import 'package:hall_management/views/admin/students/admin_students_page.dart';
import 'package:hall_management/views/login/login_page.dart';
import 'package:hall_management/views/login/role_based_login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_routes.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _adminNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.roleSelection,
    redirect: (context, state) {
      final user = Supabase.instance.client.auth.currentUser;
      final isLoggingIn = state.matchedLocation == AppRoutes.login || state.matchedLocation == AppRoutes.roleSelection;
      
      if (user == null && !isLoggingIn) {
        return AppRoutes.roleSelection;
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.roleSelection,
        builder: (context, state) => const RoleBasedLoginPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      
      // Admin Routes with Layout ShellRoute
      ShellRoute(
        navigatorKey: _adminNavigatorKey,
        builder: (context, state, child) {
          return AdminLayout(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.adminDashboard,
            builder: (context, state) => const AdminDashboardPage(),
          ),
          GoRoute(
            path: AppRoutes.adminStudents,
            builder: (context, state) => const AdminStudentsPage(),
          ),
          GoRoute(
            path: '/admin/managers',
            builder: (context, state) => const AdminManagersPage(),
          ),
          GoRoute(
            path: AppRoutes.adminRooms,
            builder: (context, state) => const Center(child: Text("Manage Rooms - Coming Soon")),
          ),
          GoRoute(
            path: AppRoutes.adminSettings,
            builder: (context, state) => const Center(child: Text("Admin Settings - Coming Soon")),
          ),
        ],
      ),

      GoRoute(
        path: AppRoutes.managerDashboard,
        builder: (context, state) => const Scaffold(body: Center(child: Text("Manager Dashboard - Coming Soon"))),
      ),
      GoRoute(
        path: AppRoutes.studentDashboard,
        builder: (context, state) => const Scaffold(body: Center(child: Text("Student Dashboard - Coming Soon"))),
      ),
    ],
  );
}