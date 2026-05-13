import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../../../core/localization/generated/app_localizations.dart';
import '../../../core/mock/models.dart';
import '../../../core/theme/tokens.dart';
import '../../../core/widgets/dark_pill_button.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key, required this.member, required this.onViewStatement});

  final Member member;
  final VoidCallback onViewStatement;

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    final currency = NumberFormat.currency(
      locale: 'ms_MY',
      symbol: '${member.sharesCurrency} ',
      decimalDigits: 2,
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        gradient: AppColors.brandGradient,
        boxShadow: AppShadows.hero,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Stack(
          children: [
            const Positioned(
              right: -60,
              top: -40,
              child: _GlowBlob(size: 240, color: Color(0x336366F1)),
            ),
            const Positioned(
              left: -40,
              bottom: -60,
              child: _GlowBlob(size: 180, color: Color(0x33C7D2FE)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.xxxl,
                AppSpacing.xxl,
                AppSpacing.xxl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.welcomeBack,
                    style: const TextStyle(
                      color: AppColors.textOnBrandMuted,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                    ),
                  ).animate().fadeIn(delay: 80.ms, duration: 300.ms),
                  const SizedBox(height: 6),
                  Text(
                    member.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.8,
                      height: 1.1,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 140.ms, duration: 350.ms)
                      .slideY(begin: 0.18, end: 0, curve: AppMotion.emphasized),
                  const SizedBox(height: AppSpacing.xxl),
                  _ClaimsPill(count: member.enquiriesInProgress),
                  const SizedBox(height: AppSpacing.lg),
                  _SharesCard(
                    total: currency.format(member.sharesTotal),
                    asOfDate: DateFormat.yMMMd().format(member.sharesAsOf),
                    monthlyChange: member.monthlyChange,
                    currency: member.sharesCurrency,
                    label: l.totalShares,
                    cta: l.viewStatement,
                    onCta: onViewStatement,
                  )
                      .animate()
                      .fadeIn(delay: 280.ms, duration: 400.ms)
                      .slideY(begin: 0.15, end: 0, curve: AppMotion.emphasized),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClaimsPill extends StatelessWidget {
  const _ClaimsPill({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 6, 16, 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$count',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: AppColors.brandIndigo,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Flexible(
            child: Text(
              l.claimsInProgress(count),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.white, size: 18),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 220.ms, duration: 350.ms)
        .slideX(begin: -0.08, end: 0, curve: AppMotion.emphasized);
  }
}

class _SharesCard extends StatelessWidget {
  const _SharesCard({
    required this.total,
    required this.asOfDate,
    required this.monthlyChange,
    required this.currency,
    required this.label,
    required this.cta,
    required this.onCta,
  });

  final String total;
  final String asOfDate;
  final double monthlyChange;
  final String currency;
  final String label;
  final String cta;
  final VoidCallback onCta;

  @override
  Widget build(BuildContext context) {
    final isUp = monthlyChange >= 0;
    final changeStr =
        '${isUp ? '+' : '-'}$currency ${monthlyChange.abs().toStringAsFixed(2)}';
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      total,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isUp ? AppColors.tagGreenBg : AppColors.tagAmberBg,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isUp ? Icons.trending_up : Icons.trending_down,
                      size: 14,
                      color: isUp
                          ? AppColors.tagGreenText
                          : AppColors.tagAmberText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      changeStr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isUp
                            ? AppColors.tagGreenText
                            : AppColors.tagAmberText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: Text(
                  'as of $asOfDate',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
              DarkPillButton(label: cta, onPressed: onCta, compact: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}
