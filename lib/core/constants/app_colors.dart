
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  
  // ADMIN — Green Theme
  
  static const Color adminDark    = Color(0xFF0B2E1A); // gradient start
  static const Color admin        = Color(0xFF1A6B3C); // primary CTA, sidebar active
  static const Color adminMid     = Color(0xFF2D8653); // hover states
  static const Color adminLight   = Color(0xFFE8F5EE); // badge bg, icon bg
  static const Color adminPale    = Color(0xFFF0F9F4); // input focused bg


  // MANAGER — Amber Theme
  
  static const Color managerDark  = Color(0xFF78350F); // gradient start
  static const Color manager      = Color(0xFFD97706); // primary
  static const Color managerLight = Color(0xFFFEF3E8); // badge bg
  static const Color managerPale  = Color(0xFFFFFBF5); // screen bg

  
  // STUDENT — Purple Theme
  
  static const Color studentDark  = Color(0xFF3B0764); // gradient start
  static const Color student      = Color(0xFF7C3AED); // primary
  static const Color studentLight = Color(0xFFF3E8FF); // badge bg, meal slots
  static const Color studentPale  = Color(0xFFF5F7FF); // screen bg

  
  // SEMANTIC
  
  static const Color success      = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color warning      = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error        = Color(0xFFEF4444);
  static const Color errorLight   = Color(0xFFFEE2E2);
  static const Color info         = Color(0xFF3B82F6);
  static const Color infoLight    = Color(0xFFEFF6FF);

  
  // BACKGROUND / NEUTRAL
  
  static const Color bgApp        = Color(0xFFF0F4F8); // page background
  static const Color surface      = Color(0xFFFFFFFF); // card, input bg
  static const Color border       = Color(0xFFE2E8F0); // card borders
  static const Color borderDark   = Color(0xFFCBD5E1); // focused borders
  static const Color divider      = Color(0xFFF8F8F8); // table row lines


  // TEXT
  
  static const Color textPrimary   = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary  = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  // SIDEBAR (Web/Desktop layout)
  
  static const Color sidebarBg     = Color(0xFF1A2332);
  static const Color sidebarBorder = Color(0xFF243044);

  
  // ROOM STATUS
  
  static const Color roomEmptyBorder = Color(0xFFD4EEDD);
  static const Color roomEmptyBg     = Color(0xFFF0F9F4);
  static const Color roomFullBorder  = Color(0xFFF5E6D0);
  static const Color roomFullBg      = Color(0xFFFFFBF5);
  static const Color roomRepairBg    = Color(0xFFF9F9F9);
  static const Color roomRepairBorder= Color(0xFFE8E8E8);

  
  // GRADIENT HELPERS
  
  static const LinearGradient adminGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [adminDark, admin],
  );

  static const LinearGradient managerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [managerDark, manager],
  );

  static const LinearGradient studentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [studentDark, student],
  );
}