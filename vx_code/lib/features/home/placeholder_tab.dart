import 'package:flutter/material.dart';

import '../../core/theme/tokens.dart';

/// Simple placeholder screen for tabs not yet implemented.
///
/// Shows a centered column with the tab [icon] in shimmer color
/// and the [label] below it.
class PlaceholderTab extends StatelessWidget {
  const PlaceholderTab({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppColors.shimmer,
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
