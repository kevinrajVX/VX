import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/localization/generated/app_localizations.dart';
import '../../../core/theme/tokens.dart';
import '../../../core/widgets/pressable.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key, required this.onServiceTap});

  final void Function(String id) onServiceTap;

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    final services = <_Service>[
      _Service('pay-dues', l.servicePayDues, Icons.payments_rounded),
      _Service('statements', l.serviceStatements, Icons.description_rounded),
      _Service('top-up', l.serviceTopUpShares, Icons.add_circle_rounded),
      _Service('marketplace', l.serviceMarketplace, Icons.storefront_rounded),
      _Service('enquiry', l.serviceEnquiry, Icons.support_agent_rounded),
      _Service('events', l.serviceEvents, Icons.event_rounded),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, i) {
        final s = services[i];
        return Pressable(
          onTap: () => onServiceTap(s.id),
          pressedScale: 0.94,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: AppShadows.card,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.lg,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: AppColors.brandGradient,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(s.icon, size: 20, color: Colors.white),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  s.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(delay: (60 * i).ms, duration: 280.ms)
            .slideY(
              begin: 0.18,
              end: 0,
              delay: (60 * i).ms,
              duration: 320.ms,
              curve: AppMotion.emphasized,
            );
      },
    );
  }
}

class _Service {
  _Service(this.id, this.label, this.icon);
  final String id;
  final String label;
  final IconData icon;
}
