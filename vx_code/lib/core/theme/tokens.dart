import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Brand ──────────────────────────────────────────────────────────────────
  static const Color brandIndigo = Color(0xFF4338CA);
  static const Color brandViolet = Color(0xFF4F46E5);
  static const Color brandBlue = Color(0xFF1A4FBF);

  /// Used by KoperasiLogo — keep compatible with existing widget.
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4338CA), Color(0xFF4F46E5)],
  );

  // ── Hero gradient: bright blue (top-right) → mid-blue → silver-blue → near-white (bottom-left) ──
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

  // ── Page / surface ─────────────────────────────────────────────────────────
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Colors.white;
  static const Color surfaceMuted = Color(0xFFF3F4F6);

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);

  /// Used by KoperasiLogo for "Berhad" wordmark on brand bg.
  static const Color textOnBrandMuted = Color(0xCCFFFFFF);

  // ── Structural ────────────────────────────────────────────────────────────
  static const Color divider = Color(0xFFE5E7EB);

  // ── Tag palette ───────────────────────────────────────────────────────────
  static const Color tagGreenBg = Color(0xFFD1FAE5);
  static const Color tagGreenText = Color(0xFF065F46);
  static const Color tagAmberBg = Color(0xFFFEF3C7);
  static const Color tagAmberText = Color(0xFFB45309);
  static const Color tagVioletBg = Color(0xFFEDE9FE);
  static const Color tagVioletText = Color(0xFF4F46E5);
  static const Color tagBlueBg = Color(0xFFDBEAFE);
  static const Color tagBlueText = Color(0xFF1D4ED8);

  // ── Shimmer / skeleton ────────────────────────────────────────────────────
  static const Color shimmer = Color(0xFFE5E7EB);
}

abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double card = 24;
  static const double pill = 999;
}

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 48;
  static const double screenPadding = 20;
}

abstract final class AppShadows {
  /// Subtle 2-layer card shadow.
  static List<BoxShadow> get card => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
          spreadRadius: -2,
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ];

  /// Blue-tinted hero shadow (blurRadius 48, offset 0,16).
  static List<BoxShadow> get hero => [
        BoxShadow(
          color: const Color(0xFF1A4FBF).withValues(alpha: 0.28),
          blurRadius: 48,
          offset: const Offset(0, 16),
          spreadRadius: -8,
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  /// Soft upward shadow for bottom navigation bar.
  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 24,
      offset: Offset(0, -8),
    ),
  ];
}

abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration base = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 420);
  static const Duration page = Duration(milliseconds: 500);

  /// M3 emphasized easing — for entrances.
  static const Curve emphasized = Cubic(0.2, 0, 0, 1);

  /// Overshoot spring — for snappy interactive feedback.
  static const Curve spring = Cubic(0.34, 1.56, 0.64, 1);

  /// Gentle spring out — for large UI elements entering the screen.
  static const Curve springOut = Cubic(0.22, 1.0, 0.36, 1.0);
}
