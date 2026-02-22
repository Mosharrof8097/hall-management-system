
import 'package:go_router/go_router.dart';
import 'package:hall_management/views/login/login_page.dart';
import 'package:hall_management/views/login/role_based_login_page.dart';

import 'app_routes.dart';



class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.roleSelection,

    routes: [
      GoRoute(
        path: AppRoutes.roleSelection,
        builder: (context, state) => const RoleBasedLoginPage(),
      ),

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}