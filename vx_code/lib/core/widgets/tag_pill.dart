import 'package:flutter/material.dart';

import '../mock/models.dart';
import '../theme/tokens.dart';

/// A small rounded pill with a [label] and a [color] variant.
///
/// Uses [TagColor] enum to map to the appropriate background and text colors.
/// 11px w700 text, horizontal padding 8, vertical padding 4.
class TagPill extends StatelessWidget {
  const TagPill({super.key, required this.label, required this.color});

  final String label;
  final TagColor color;

  ({Color bg, Color fg}) get _palette {
    switch (color) {
      case TagColor.blue:
        return (bg: AppColors.tagBlueBg, fg: AppColors.tagBlueText);
      case TagColor.amber:
        return (bg: AppColors.tagAmberBg, fg: AppColors.tagAmberText);
      case TagColor.green:
        return (bg: AppColors.tagGreenBg, fg: AppColors.tagGreenText);
      case TagColor.violet:
        return (bg: AppColors.tagVioletBg, fg: AppColors.tagVioletText);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = _palette;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: p.bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: p.fg,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
