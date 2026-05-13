import 'package:flutter/material.dart';

import '../mock/models.dart';
import '../theme/tokens.dart';

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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: p.bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: p.fg,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
