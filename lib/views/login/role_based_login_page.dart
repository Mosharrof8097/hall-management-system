import 'package:flutter/material.dart';
import 'package:hall_management/views/login/sections/about_section.dart';
import 'sections/header_section.dart';
import 'sections/hero_section.dart';

class RoleBasedLoginPage extends StatelessWidget {
  const RoleBasedLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            HeroSection(),
            AboutSection()

            /// Next Section (About / Features / Footer)
          ],
        ),
      ),
    );
  }
}
