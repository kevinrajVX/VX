import 'package:flutter/material.dart';

import '../theme/tokens.dart';
import 'pressable.dart';

/// Circular icon button: white surface, card shadow, [AppColors.textPrimary] icon.
///
/// Fixed size 40×40. [onBrand] variant uses [AppColors.brandViolet] background
/// and white icon.
class SoftIconButton extends StatelessWidget {
  const SoftIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 40,
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
          color: onBrand ? AppColors.brandViolet : AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: onBrand ? null : AppShadows.card,
        ),
        child: Icon(
          icon,
          size: size * 0.45,
          color: onBrand ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}
