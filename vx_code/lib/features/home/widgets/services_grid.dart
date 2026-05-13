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
        childAspectRatio: 0.88,
      ),
      itemBuilder: (context, i) {
        final s = services[i];
        final gradient = AppColors.serviceGradients[i];
        final bgTint = AppColors.serviceBgTints[i];

        return Pressable(
          onTap: () => onServiceTap(s.id),
          pressedScale: 0.92,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.xl),
              boxShadow: AppShadows.card,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: bgTint,
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.lg,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon container with gradient + glow shadow
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      boxShadow: [
                        BoxShadow(
                          color: (gradient.colors.first).withValues(alpha: 0.40),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Icon(s.icon, size: 26, color: Colors.white),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    s.label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(delay: (70 * i).ms, duration: 300.ms)
            .scale(
              begin: const Offset(0.82, 0.82),
              delay: (70 * i).ms,
              duration: 480.ms,
              curve: AppMotion.spring,
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
