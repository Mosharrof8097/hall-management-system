import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hall_management/controllers/login_controller.dart';
import 'package:hall_management/core/constants/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(LoginController());
    final theme = Theme.of(context);

    return Scaffold(
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
                child: Form(
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
                          if (!GetUtils.isEmail(value)) {
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
                      Obx(() => SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () => controller.login(context),
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text("লগইন করুন →"),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}