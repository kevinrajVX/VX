import 'package:flutter/material.dart';

import '../theme/tokens.dart';
import 'pressable.dart';

class SoftIconButton extends StatelessWidget {
  const SoftIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 44,
    this.onBrand = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final bool onBrand;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: onBrand
              ? Colors.white.withValues(alpha: 0.18)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          boxShadow: onBrand ? null : AppShadows.card,
          border: onBrand
              ? Border.all(color: Colors.white.withValues(alpha: 0.24))
              : null,
        ),
        child: Icon(
          icon,
          size: size * 0.42,
          color: onBrand ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}
