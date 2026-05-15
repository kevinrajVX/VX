import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color brandIndigo = Color(0xFF1E1B4B);
  static const Color brandViolet = Color(0xFF4F46E5);
  static const Color brandViolet600 = Color(0xFF6366F1);
  static const Color brandVioletLight = Color(0xFF818CF8);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandIndigo, brandViolet],
  );

  // Hero card: bright blue top-right → silver → near-white bottom-left
  // Matches the reference gradient (image 2)
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.0, 0.38, 0.70, 1.0],
    colors: [
      Color(0xFF1A4FBF),
      Color(0xFF4A8FD4),
      Color(0xFFBFCFE8),
      Color(0xFFF0F3FA),
    ],
  );

  static const LinearGradient brandGradientSoft = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF312E81), Color(0xFF6366F1)],
  );

  // 6 unique service gradients — each tile has its own personality
  static const List<LinearGradient> serviceGradients = [
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF6366F1), Color(0xFF4338CA)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF0EA5E9), Color(0xFF0369A1)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF10B981), Color(0xFF059669)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFEC4899), Color(0xFFBE185D)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    ),
  ];

  // Matching tinted card backgrounds (6% opacity of gradient start)
  static const List<Color> serviceBgTints = [
    Color(0x0D6366F1),
    Color(0x0D0EA5E9),
    Color(0x0D10B981),
    Color(0x0DF59E0B),
    Color(0x0DEC4899),
    Color(0x0D8B5CF6),
  ];

  static const Color background = Color(0xFFF2F3FA);
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
      color: Color(0x12000000),
      blurRadius: 20,
      offset: Offset(0, 6),
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 6,
      offset: Offset(0, 2),
      spreadRadius: -1,
    ),
  ];

  // Deeply colored violet shadow for the hero card
  static const List<BoxShadow> hero = [
    BoxShadow(
      color: Color(0x554F46E5),
      blurRadius: 64,
      offset: Offset(0, 24),
      spreadRadius: -12,
    ),
    BoxShadow(
      color: Color(0x301E1B4B),
      blurRadius: 24,
      offset: Offset(0, 8),
      spreadRadius: -4,
    ),
  ];

  // Double shadow for premium card depth
  static const List<BoxShadow> elevated = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 32,
      offset: Offset(0, 12),
      spreadRadius: -8,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 2),
      spreadRadius: -2,
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
  static const Curve springOut = Cubic(0.22, 1.0, 0.36, 1.0);
}
