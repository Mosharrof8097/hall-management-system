import 'package:flutter/material.dart';
import 'package:hall_management/core/constants/app_theme.dart';

import 'package:hall_management/core/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hqyueiwrlfumspuovemo.supabase.co',
    anonKey: 'sb_publishable_5o_Kbdh_jbGLxt7QzeZw8A_DaklgfuO',
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, 
      routerConfig:AppRoutes.router,
    );
  }
}