

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ══════════════════════════════
  // DISPLAY / HERO
  // Font: DM Sans | Size: 28–32 | Weight: 800
  // Usage: Splash title, page hero
  // ══════════════════════════════
  static TextStyle display({Color color = AppColors.textPrimary}) =>
      GoogleFonts.dmSans(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: color,
        height: 1.2,
      );

  // ══════════════════════════════
  // PAGE TITLE
  // Font: DM Sans | Size: 22 | Weight: 800
  // Usage: Dashboard titles, screen names
  // ══════════════════════════════
  static TextStyle pageTitle({Color color = AppColors.textPrimary}) =>
      GoogleFonts.dmSans(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: color,
      );

  // ══════════════════════════════
  // BENGALI HEADER
  // Font: Hind Siliguri | Size: 16–20 | Weight: 700
  // Usage: বাংলা section headers, screen titles
  // ══════════════════════════════
  static TextStyle bengaliHeader({
    double fontSize = 18,
    Color color = AppColors.textPrimary,
  }) =>
      GoogleFonts.hindSiliguri(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: color,
      );

  // ══════════════════════════════
  // CARD TITLE / SECTION HEADING
  // Font: DM Sans | Size: 13–14 | Weight: 600
  // Usage: Card headers, table column labels
  // ══════════════════════════════
  static TextStyle cardTitle({Color color = AppColors.textPrimary}) =>
      GoogleFonts.dmSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: color,
      );

  // ══════════════════════════════
  // BODY — BENGALI
  // Font: Hind Siliguri | Size: 11–13 | Weight: 400
  // Usage: Notice body, description, table cells বাংলায়
  // ══════════════════════════════
  static TextStyle bodyBengali({
    double fontSize = 12,
    Color color = AppColors.textSecondary,
    FontWeight weight = FontWeight.w400,
  }) =>
      GoogleFonts.hindSiliguri(
        fontSize: fontSize,
        fontWeight: weight,
        color: color,
        height: 1.6,
      );

  // ══════════════════════════════
  // BODY — ENGLISH
  // Font: DM Sans | Size: 12–14 | Weight: 400–500
  // Usage: General content, descriptions
  // ══════════════════════════════
  static TextStyle body({
    double fontSize = 13,
    Color color = AppColors.textSecondary,
    FontWeight weight = FontWeight.w400,
  }) =>
      GoogleFonts.dmSans(
        fontSize: fontSize,
        fontWeight: weight,
        color: color,
      );

  // ══════════════════════════════
  // LABEL / CAPTION / METADATA
  // Font: DM Mono | Size: 9–11 | Weight: 500 + UPPERCASE
  // Usage: IDs, labels, version tags, metadata
  // ══════════════════════════════
  static TextStyle label({
    double fontSize = 10,
    Color color = AppColors.textTertiary,
  }) =>
      GoogleFonts.dmMono(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.8,
      );

  // ══════════════════════════════
  // STUDENT ID / MONO TEXT
  // Font: DM Mono | Normal case
  // Usage: MEC-2022-CSE-045 style IDs
  // ══════════════════════════════
  static TextStyle studentId({Color color = AppColors.textTertiary}) =>
      GoogleFonts.dmMono(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: color,
      );

  // ══════════════════════════════
  // BUTTON TEXT
  // Font: Hind Siliguri | Size: 13 | Weight: 800
  // Usage: All CTA buttons বাংলায়
  // ══════════════════════════════
  static TextStyle buttonBengali({Color color = AppColors.textOnPrimary}) =>
      GoogleFonts.hindSiliguri(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        color: color,
      );

  // ══════════════════════════════
  // STATS VALUE (Big number)
  // Font: DM Sans | Size: 22–28 | Weight: 800
  // Usage: Dashboard stat cards
  // ══════════════════════════════
  static TextStyle statValue({
    double fontSize = 24,
    Color color = AppColors.textPrimary,
  }) =>
      GoogleFonts.dmSans(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        color: color,
        height: 1.0,
      );

  // ══════════════════════════════
  // BADGE / TAG TEXT
  // Font: DM Sans | Size: 10–11 | Weight: 700
  // Usage: Status badges, filter chips
  // ══════════════════════════════
  static TextStyle badge({Color color = AppColors.admin}) =>
      GoogleFonts.dmSans(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: color,
      );

  // ══════════════════════════════
  // NOTICE TITLE
  // Font: Hind Siliguri | Size: 13 | Weight: 800
  // ══════════════════════════════
  static TextStyle noticeTitle({Color color = AppColors.textPrimary}) =>
      GoogleFonts.hindSiliguri(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        color: color,
      );

  // ══════════════════════════════
  // TABLE HEADER
  // Font: DM Sans | Size: 10 | Weight: 700 | UPPERCASE
  // ══════════════════════════════
  static TextStyle tableHeader({Color color = AppColors.textTertiary}) =>
      GoogleFonts.dmSans(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.5,
      );

  // ══════════════════════════════
  // SIDEBAR NAV ITEM
  // Font: Hind Siliguri | Size: 12 | Weight: 600
  // ══════════════════════════════
  static TextStyle sidebarItem({
    Color color = AppColors.textTertiary,
    bool isActive = false,
  }) =>
      GoogleFonts.hindSiliguri(
        fontSize: 12,
        fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
        color: isActive ? AppColors.textOnPrimary : color,
      );
}