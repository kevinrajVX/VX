import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tokens.dart';

/// Provides the single light [ThemeData] for the app.
///
/// Typography: Plus Jakarta Sans for body text, Space Grotesk for display/headings.
/// Color scheme seeded from [AppColors.brandViolet] via Material 3.
abstract final class AppTheme {
  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);

    // Body/label text — Plus Jakarta Sans
    final bodyTextTheme = GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );

    // Heading text — Space Grotesk
    final headingTextTheme = GoogleFonts.spaceGroteskTextTheme(base.textTheme);

    final textTheme = bodyTextTheme.copyWith(
      displayLarge: headingTextTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -1.2,
      ),
      displayMedium: headingTextTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.8,
      ),
      displaySmall: headingTextTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      ),
      headlineLarge: headingTextTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      ),
      headlineMedium: headingTextTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
      ),
      headlineSmall: headingTextTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      titleLarge: bodyTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
      ),
      titleMedium: bodyTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleSmall: bodyTextTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: bodyTextTheme.bodyLarge?.copyWith(color: AppColors.textPrimary),
      bodyMedium: bodyTextTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
      bodySmall: bodyTextTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
      labelLarge: bodyTextTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      labelMedium: bodyTextTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
      labelSmall: bodyTextTheme.labelSmall?.copyWith(
        color: AppColors.textSecondary,
      ),
    );

    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.brandViolet,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.brandViolet,
      onPrimary: Colors.white,
      secondary: AppColors.brandBlue,
      onSecondary: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceMuted,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        surfaceTintColor: Colors.transparent,
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        margin: EdgeInsets.zero,
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.textPrimary,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.lg,
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      splashFactory: InkSparkle.splashFactory,
    );
  }
}
