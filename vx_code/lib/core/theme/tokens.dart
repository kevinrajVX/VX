import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color brandIndigo = Color(0xFF1E1B4B);
  static const Color brandViolet = Color(0xFF4F46E5);
  static const Color brandViolet600 = Color(0xFF6366F1);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandIndigo, brandViolet],
  );

  static const LinearGradient brandGradientSoft = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF312E81), Color(0xFF6366F1)],
  );

  static const Color background = Color(0xFFF4F6FA);
  static const Color surface = Colors.white;
  static const Color surfaceMuted = Color(0xFFEDF0F7);

  static const Color textPrimary = Color(0xFF0F0F1A);
  static const Color textSecondary = Color(0xFF6B6B7B);
  static const Color textOnBrand = Colors.white;
  static const Color textOnBrandMuted = Color(0xCCFFFFFF);

  static const Color buttonDark = Color(0xFF0F0F1A);
  static const Color buttonDarkPressed = Color(0xFF1F1F2E);

  static const Color tagBlueBg = Color(0xFFDCE6FB);
  static const Color tagBlueText = Color(0xFF1E4FBF);
  static const Color tagVioletBg = Color(0xFFE5E1FF);
  static const Color tagVioletText = Color(0xFF4F46E5);
  static const Color tagAmberBg = Color(0xFFFFE9C7);
  static const Color tagAmberText = Color(0xFFB8730A);
  static const Color tagGreenBg = Color(0xFFD7F2DF);
  static const Color tagGreenText = Color(0xFF1A7A3E);

  static const Color divider = Color(0xFFE3E6EE);
  static const Color shimmer = Color(0xFFE9ECF3);
}

class AppRadius {
  AppRadius._();
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 28;
  static const double card = 28;
  static const double image = 20;
  static const double pill = 999;
}

class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;
  static const double screenPadding = 20;
}

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 24,
      offset: Offset(0, 8),
      spreadRadius: -4,
    ),
  ];

  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 16,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> hero = [
    BoxShadow(
      color: Color(0x261E1B4B),
      blurRadius: 32,
      offset: Offset(0, 12),
      spreadRadius: -8,
    ),
  ];
}

class AppMotion {
  AppMotion._();
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration base = Duration(milliseconds: 280);
  static const Duration slow = Duration(milliseconds: 420);
  static const Duration page = Duration(milliseconds: 480);

  static const Curve emphasized = Cubic(0.2, 0, 0, 1);
  static const Curve standard = Curves.easeOutCubic;
  static const Curve spring = Cubic(0.34, 1.56, 0.64, 1);
}
