// lib/core/theme/app_theme.dart
// ✅ Material3 theme built from MEC Figma Design System v2.0

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // ── Color Scheme ──────────────────────────
      colorScheme: const ColorScheme.light(
        primary:          AppColors.admin,
        onPrimary:        AppColors.textOnPrimary,
        primaryContainer: AppColors.adminLight,
        onPrimaryContainer: AppColors.adminDark,
        secondary:        AppColors.adminMid,
        surface:          AppColors.surface,
        surfaceVariant:   AppColors.bgApp,
        background:       AppColors.bgApp,
        onBackground:     AppColors.textPrimary,
        onSurface:        AppColors.textPrimary,
        error:            AppColors.error,
        onError:          AppColors.textOnPrimary,
        outline:          AppColors.border,
        outlineVariant:   AppColors.divider,
      ),

      // ── Scaffold ──────────────────────────────
      scaffoldBackgroundColor: AppColors.bgApp,

      // ── Text Theme (DM Sans base) ──────────────
      textTheme: GoogleFonts.dmSansTextTheme().copyWith(
        // Display → page hero
        displayLarge: GoogleFonts.dmSans(
          fontSize: 32, fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
        displayMedium: GoogleFonts.dmSans(
          fontSize: 28, fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
        // Headline → section titles
        headlineLarge: GoogleFonts.dmSans(
          fontSize: 22, fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
        headlineMedium: GoogleFonts.dmSans(
          fontSize: 18, fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        headlineSmall: GoogleFonts.dmSans(
          fontSize: 16, fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        // Title → card headers
        titleLarge: GoogleFonts.dmSans(
          fontSize: 14, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: GoogleFonts.dmSans(
          fontSize: 13, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleSmall: GoogleFonts.dmSans(
          fontSize: 12, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        // Body
        bodyLarge: GoogleFonts.dmSans(
          fontSize: 14, fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 13, fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        bodySmall: GoogleFonts.dmSans(
          fontSize: 11, fontWeight: FontWeight.w400,
          color: AppColors.textTertiary,
        ),
        // Label → metadata, IDs
        labelLarge: GoogleFonts.dmMono(
          fontSize: 11, fontWeight: FontWeight.w500,
          color: AppColors.textTertiary,
        ),
        labelMedium: GoogleFonts.dmMono(
          fontSize: 10, fontWeight: FontWeight.w500,
          color: AppColors.textTertiary,
          letterSpacing: 0.5,
        ),
        labelSmall: GoogleFonts.dmMono(
          fontSize: 9, fontWeight: FontWeight.w500,
          color: AppColors.textTertiary,
          letterSpacing: 0.8,
        ),
      ),

      // ── ElevatedButton ────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.admin,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 13,
          ),
          textStyle: GoogleFonts.hindSiliguri(
            fontSize: 13, fontWeight: FontWeight.w800,
          ),
        ),
      ),

      // ── OutlinedButton ────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.admin,
          side: const BorderSide(color: AppColors.border, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 13,
          ),
          textStyle: GoogleFonts.hindSiliguri(
            fontSize: 13, fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ── TextButton ────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.admin,
          textStyle: GoogleFonts.hindSiliguri(
            fontSize: 13, fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ── InputDecoration ───────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14, vertical: 13,
        ),
        hintStyle: GoogleFonts.hindSiliguri(
          fontSize: 13,
          color: AppColors.textTertiary,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: GoogleFonts.hindSiliguri(
          fontSize: 13,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
        // Default border
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        // Focused — Admin green
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.admin, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      ),

      // ── Card ──────────────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── AppBar ────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: GoogleFonts.hindSiliguri(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        toolbarHeight: 56,
      ),

      // ── BottomNavBar (mobile) ─────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.admin,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.hindSiliguri(
          fontSize: 10, fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: GoogleFonts.hindSiliguri(
          fontSize: 10, fontWeight: FontWeight.w500,
        ),
      ),

      // ── Divider ───────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 0,
      ),

      // ── Chip ──────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.bgApp,
        labelStyle: GoogleFonts.hindSiliguri(
          fontSize: 11, fontWeight: FontWeight.w700,
          color: AppColors.textSecondary,
        ),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),

      // ── FloatingActionButton ──────────────────
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.admin,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 4,
        shape: CircleBorder(),
      ),

      // ── Snackbar ──────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.sidebarBg,
        contentTextStyle: GoogleFonts.hindSiliguri(
          fontSize: 13,
          color: AppColors.textOnPrimary,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // ── Dialog ────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        titleTextStyle: GoogleFonts.hindSiliguri(
          fontSize: 16, fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  // ── Role-specific themes ───────────────────────
  // Use these when you need manager or student color overrides

  static ThemeData managerTheme() {
    return lightTheme.copyWith(
      colorScheme: lightTheme.colorScheme.copyWith(
        primary: AppColors.manager,
        primaryContainer: AppColors.managerLight,
        onPrimaryContainer: AppColors.managerDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.manager,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: lightTheme.inputDecorationTheme.copyWith(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.manager, width: 2),
        ),
      ),
    );
  }

  static ThemeData studentTheme() {
    return lightTheme.copyWith(
      colorScheme: lightTheme.colorScheme.copyWith(
        primary: AppColors.student,
        primaryContainer: AppColors.studentLight,
        onPrimaryContainer: AppColors.studentDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.student,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: lightTheme.inputDecorationTheme.copyWith(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.student, width: 2),
        ),
      ),
    );
  }
}