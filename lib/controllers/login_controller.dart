// lib/core/controllers/login_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/services/auth_repository.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  final AuthRepository _repo         = AuthRepository();
  final AuthController _authController = Get.find();

  final formKey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  final isLoading = false.obs;

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final user = await _repo.login(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );

      _authController.setUser(user);

      if (!context.mounted) return;

      // ✅ FIX 1: roleSelection না গিয়ে role অনুযায়ী সরাসরি dashboard এ যাও
      final role = user.role;
      debugPrint('Login success. Role: $role'); // console এ দেখো

      switch (role) {
        case 'admin':
          context.go(AppRoutes.adminDashboard);
          break;
        case 'manager':
          context.go(AppRoutes.managerDashboard);
          break;
        case 'student':
        default:
          context.go(AppRoutes.studentDashboard);
          break;
      }

    } catch (e) {
      final raw = e.toString();
      debugPrint('Login error raw: $raw'); // ✅ console এ exact error দেখো

      final msg = _getErrorMessage(raw);

      // ✅ FIX 2: GoRouter + GetX context conflict fix
      // Get.snackbar GoRouter context এ কাজ করে না
      // ScaffoldMessenger সবচেয়ে reliable
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '❌ লগইন ব্যর্থ',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: Color(0xFFDC2626),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  msg,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFDC2626),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFFEE2E2),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  String _getErrorMessage(String raw) {
    debugPrint('Raw error for parsing: $raw');
    final msg = raw.toLowerCase();

    if (msg.contains('invalid login credentials') ||
        msg.contains('invalid email or password') ||
        msg.contains('wrong password')) {
      return 'ইমেইল অথবা পাসওয়ার্ড ভুল';
    }
    if (msg.contains('email not confirmed')) {
      return 'ইমেইল এখনো verify করা হয়নি — inbox চেক করুন';
    }
    if (msg.contains('user not found') || msg.contains('no user')) {
      return 'এই ইমেইলে কোনো অ্যাকাউন্ট নেই';
    }
    if (msg.contains('network') || msg.contains('socket') ||
        msg.contains('connection')) {
      return 'ইন্টারনেট সংযোগ নেই';
    }
    if (msg.contains('too many requests')) {
      return 'অনেকবার চেষ্টা হয়েছে — কিছুক্ষণ পরে আবার করুন';
    }

    // ✅ fallback — exact error দেখাও যাতে debug হয়
    return 'এরর: $raw';
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.onClose();
  }
}