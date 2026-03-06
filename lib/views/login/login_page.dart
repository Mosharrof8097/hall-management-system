import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hall_management/providers/login_provider.dart';
import 'package:hall_management/core/constants/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Scaffold(
        body: Row(
          children: [
            // LEFT PANEL
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                  gradient: AppColors.adminGradient,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.account_balance,
                        size: 48, color: Colors.white),
                    const SizedBox(height: 24),
                    Text(
                      "ওমর একুশে হল",
                      style: theme.textTheme.displayMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "MEC Hall System",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),

            // RIGHT PANEL
            Expanded(
              flex: 6,
              child: Center(
                child: SizedBox(
                  width: 380,
                  child: Consumer<LoginProvider>(
                    builder: (context, controller, child) {
                      return Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("লগইন করুন",
                                style: theme.textTheme.displayMedium),
                            const SizedBox(height: 30),

                            // EMAIL
                            TextFormField(
                              controller: controller.emailCtrl,
                              decoration: const InputDecoration(
                                labelText: "ইমেইল",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "ইমেইল দিতে হবে";
                                }
                                final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                                if (!emailRegex.hasMatch(value)) {
                                  return "সঠিক ইমেইল নয়";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            // PASSWORD
                            TextFormField(
                              controller: controller.passCtrl,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "পাসওয়ার্ড",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "পাসওয়ার্ড দিতে হবে";
                                }
                                if (value.length < 6) {
                                  return "পাসওয়ার্ড কমপক্ষে ৬ অক্ষর হতে হবে";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 30),

                            // BUTTON
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: controller.isLoading
                                    ? null
                                    : () => controller.login(context),
                                child: controller.isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Text("লগইন করুন →"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}