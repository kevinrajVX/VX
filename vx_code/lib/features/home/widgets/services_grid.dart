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
      _Service('pay-dues', l.servicePayDues, Icons.payments_rounded, 0),
      _Service('statements', l.serviceStatements, Icons.description_rounded, 1),
      _Service('top-up', l.serviceTopUpShares, Icons.add_circle_rounded, 2),
      _Service('marketplace', l.serviceMarketplace, Icons.storefront_rounded, 3),
      _Service('enquiry', l.serviceEnquiry, Icons.support_agent_rounded, 4),
      _Service('events', l.serviceEvents, Icons.event_rounded, 5),
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
        childAspectRatio: 2.1,
      ),
      itemBuilder: (context, i) {
        final s = services[i];
        final gradient = AppColors.serviceGradients[s.colorIndex];

        return Pressable(
          onTap: () => onServiceTap(s.id),
          pressedScale: 0.93,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              boxShadow: AppShadows.card,
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  alignment: Alignment.center,
                  child: Icon(s.icon, size: 16, color: Colors.white),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    s.label,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      height: 1.2,
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
            .fadeIn(delay: (60 * i).ms, duration: 280.ms)
            .scale(
              begin: const Offset(0.85, 0.85),
              delay: (60 * i).ms,
              duration: 400.ms,
              curve: AppMotion.spring,
            );
      },
    );
  }
}

class _Service {
  _Service(this.id, this.label, this.icon, this.colorIndex);
  final String id;
  final String label;
  final IconData icon;
  final int colorIndex;
}
