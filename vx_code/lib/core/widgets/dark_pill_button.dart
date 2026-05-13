import 'package:flutter/material.dart';

import '../theme/tokens.dart';
import 'pressable.dart';

class DarkPillButton extends StatelessWidget {
  const DarkPillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.compact = false,
    this.onBrand = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool compact;
  final bool onBrand;

  @override
  Widget build(BuildContext context) {
    final fg = onBrand ? AppColors.buttonDark : Colors.white;
    final bg = onBrand ? Colors.white : AppColors.buttonDark;
    return Pressable(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.xl : AppSpacing.xxl,
          vertical: compact ? AppSpacing.md : AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          boxShadow: onBrand
              ? AppShadows.card
              : [
                  BoxShadow(
                    color: AppColors.buttonDark.withValues(alpha: 0.18),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                    spreadRadius: -4,
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: fg),
              const SizedBox(width: AppSpacing.sm),
            ],
            Text(
              label,
              style: TextStyle(
                color: fg,
                fontSize: compact ? 13 : 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
