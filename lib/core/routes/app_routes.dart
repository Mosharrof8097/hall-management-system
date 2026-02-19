
import 'package:go_router/go_router.dart';
import 'package:hall_management/views/login/role_based_login_page.dart';


class AppRoutes {
  static final GoRouter router = GoRouter(routes: [
    GoRoute(path: '/',
    builder:(context,state)=> RoleBasedLoginPage(),
    )

  ]);
}
