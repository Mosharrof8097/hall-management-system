import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hall_management/views/admin/billing/admin_billing_page.dart';
import 'package:hall_management/views/admin/dashboard/admin_dashboard_page.dart';
import 'package:hall_management/views/admin/layout/admin_layout.dart';
import 'package:hall_management/views/admin/managers/admin_managers_page.dart';
import 'package:hall_management/views/admin/notices/admin_notices_page.dart';
import 'package:hall_management/views/admin/reports/admin_reports_page.dart';
import 'package:hall_management/views/admin/rooms/admin_rooms_page.dart';
import 'package:hall_management/views/admin/students/admin_students_page.dart';
import 'package:hall_management/views/admin/vacancy/admin_vacancy_page.dart';
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
      final isLoggingIn = state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.roleSelection;
      if (user == null && !isLoggingIn) return AppRoutes.roleSelection;
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.roleSelection, builder: (c, s) => const RoleBasedLoginPage()),
      GoRoute(path: AppRoutes.login,         builder: (c, s) => const LoginPage()),

      // ─── Admin Shell ──────────────────────────────────────────────────
      ShellRoute(
        navigatorKey: _adminNavigatorKey,
        builder: (context, state, child) => AdminLayout(child: child),
        routes: [
          GoRoute(path: AppRoutes.adminDashboard, builder: (c, s) => const AdminDashboardPage()),
          GoRoute(path: AppRoutes.adminStudents,  builder: (c, s) => const AdminStudentsPage()),
          GoRoute(path: AppRoutes.adminManagers,  builder: (c, s) => const AdminManagersPage()),
          GoRoute(path: AppRoutes.adminRooms,     builder: (c, s) => const AdminRoomsPage()),
          GoRoute(path: AppRoutes.adminBilling,   builder: (c, s) => const AdminBillingPage()),
          GoRoute(path: AppRoutes.adminNotices,   builder: (c, s) => const AdminNoticesPage()),
          GoRoute(path: AppRoutes.adminVacancy,   builder: (c, s) => const AdminVacancyPage()),
          GoRoute(path: AppRoutes.adminReports,   builder: (c, s) => const AdminReportsPage()),
          GoRoute(path: AppRoutes.adminSettings,  builder: (c, s) => const Center(child: Text('Settings — Coming Soon'))),
        ],
      ),

      GoRoute(path: AppRoutes.managerDashboard, builder: (c, s) => const Scaffold(body: Center(child: Text('Manager Dashboard — Coming Soon')))),
      GoRoute(path: AppRoutes.studentDashboard, builder: (c, s) => const Scaffold(body: Center(child: Text('Student Dashboard — Coming Soon')))),
    ],
  );
}