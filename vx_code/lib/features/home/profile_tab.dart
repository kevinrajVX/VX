import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth/auth_provider.dart';
import '../../core/localization/generated/app_localizations.dart';
import '../../core/theme/tokens.dart';
import '../../core/widgets/koperasi_logo.dart';
import '../../core/widgets/pressable.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL10n.of(context);
    final auth = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.xxxl),

              // Avatar / logo area
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.tagVioletBg,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.card,
                ),
                child: const Center(
                  child: KoperasiLogo(size: 44),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Username
              if (auth.username != null)
                Text(
                  auth.username!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.4,
                  ),
                ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                l.loggedInAs(auth.username ?? ''),
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: AppSpacing.huge),

              // Switch account row
              _ActionRow(
                icon: Icons.swap_horiz_rounded,
                label: l.switchAccount,
                onTap: () => ref.read(authProvider.notifier).logout(),
              ),

              const Divider(height: 1, color: AppColors.divider),

              // Sign out row
              _ActionRow(
                icon: Icons.logout_rounded,
                label: l.signOut,
                onTap: () => ref.read(authProvider.notifier).logout(),
                destructive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? Colors.red.shade600 : AppColors.textPrimary;

    return Pressable(
      onTap: onTap,
      pressedScale: 0.97,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
