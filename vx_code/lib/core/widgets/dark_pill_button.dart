import 'package:flutter/material.dart';

import '../theme/tokens.dart';
import 'pressable.dart';

/// A Pressable pill-shaped button with two appearance variants.
///
/// Default: dark [AppColors.textPrimary] background, white text.
/// [onBrand] = true: [AppColors.brandViolet] background, white text.
///
/// Set [compact] for reduced padding. Provide [icon] for a leading icon.
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
    final bg = onBrand ? AppColors.brandViolet : AppColors.textPrimary;
    const fg = Colors.white;

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
          boxShadow: AppShadows.card,
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
