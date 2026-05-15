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
      _Service('pay-dues', l.servicePayDues, Icons.payments_outlined),
      _Service('statements', l.serviceStatements, Icons.download_outlined),
      _Service('top-up', l.serviceTopUpShares, Icons.add_circle_outline_rounded),
      _Service('marketplace', l.serviceMarketplace, Icons.storefront_outlined),
      _Service('enquiry', l.serviceEnquiry, Icons.support_agent_outlined),
      _Service('events', l.serviceEvents, Icons.event_outlined),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: AppSpacing.sm,
        crossAxisSpacing: AppSpacing.sm,
        childAspectRatio: 1.9,
      ),
      itemBuilder: (context, i) {
        final s = services[i];

        return Pressable(
          onTap: () => onServiceTap(s.id),
          pressedScale: 0.94,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: AppShadows.card,
            ),
            child: Row(
              children: [
                // Monochrome icon container — matches reference
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    s.icon,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    s.label,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      height: 1.25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(delay: (55 * i).ms, duration: 260.ms)
            .slideY(
              begin: 0.12,
              end: 0,
              delay: (55 * i).ms,
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
