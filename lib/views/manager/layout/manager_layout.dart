import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../providers/auth_provider.dart';

class ManagerLayout extends StatefulWidget {
  final Widget child;
  const ManagerLayout({super.key, required this.child});

  @override
  State<ManagerLayout> createState() => _ManagerLayoutState();
}

class _ManagerLayoutState extends State<ManagerLayout> {
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
              title: const Text('Manager Panel', style: TextStyle(color: Colors.white)),
              backgroundColor: AppColors.managerDark,
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
              decoration: const BoxDecoration(
                gradient: AppColors.managerGradient,
              ),
              child: _buildSidebar(context),
            ),
          Expanded(
            child: Column(
              children: [
                if (isDesktop) _buildTopNav(context),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF9F5EF),
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
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => setState(() => isSidebarExpanded = !isSidebarExpanded),
          ),
          const Spacer(),
          const Text('Welcome, Manager', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 16),
          const CircleAvatar(
            backgroundColor: AppColors.manager,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    final currentRoute = GoRouterState.of(context).matchedLocation;
    final bool isDesktop = MediaQuery.of(context).size.width >= 1100;
    final bool showText = isSidebarExpanded || !isDesktop;

    return Column(
      children: [
        if (!isDesktop) const SizedBox(height: 50),
        if (isDesktop)
          Container(
            height: 60,
            alignment: showText ? Alignment.centerLeft : Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: showText
                ? const Text('MEC Manager', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                : const Icon(Icons.restaurant, color: Colors.white),
          ),
        const Divider(color: Colors.white24),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _navItem(context, Icons.dashboard,     'Dashboard',     AppRoutes.managerDashboard,  currentRoute == AppRoutes.managerDashboard),
              _navItem(context, Icons.restaurant,    'Daily Meal',    AppRoutes.managerMeal,       currentRoute.startsWith(AppRoutes.managerMeal)),
              _navItem(context, Icons.shopping_cart, 'Bazar / Cost',  AppRoutes.managerBazar,      currentRoute.startsWith(AppRoutes.managerBazar)),
              _navItem(context, Icons.account_balance_wallet, 'Mill Account', AppRoutes.managerAccount, currentRoute.startsWith(AppRoutes.managerAccount)),
              _navItem(context, Icons.receipt,       'Student Dues',  AppRoutes.managerDues,       currentRoute.startsWith(AppRoutes.managerDues)),
              _navItem(context, Icons.campaign,      'Notices',       AppRoutes.managerNotices,    currentRoute.startsWith(AppRoutes.managerNotices)),
            ],
          ),
        ),
        const Divider(color: Colors.white24),
        _navItem(context, Icons.logout, 'Logout', '', false, onTap: () async {
          await context.read<AuthProvider>().logout();
          if (context.mounted) context.go(AppRoutes.login);
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _navItem(BuildContext context, IconData icon, String title, String route, bool isActive, {VoidCallback? onTap}) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 1100;
    final bool showText = isSidebarExpanded || !isDesktop;

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
