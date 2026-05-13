import 'dart:ui';

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
        gradient: AppColors.heroGradient,
        boxShadow: AppShadows.hero,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Stack(
          children: [
            // Large ambient glow — top-right
            const Positioned(
              right: -80,
              top: -80,
              child: _GlowBlob(size: 320, color: Color(0x666366F1)),
            ),
            // Large ambient glow — bottom-left
            const Positioned(
              left: -60,
              bottom: -80,
              child: _GlowBlob(size: 260, color: Color(0x554F86DC)),
            ),
            // Accent glow — top-left corner
            const Positioned(
              left: -30,
              top: -30,
              child: _GlowBlob(size: 160, color: Color(0x33818CF8)),
            ),
            // Subtle dot grid texture
            Positioned.fill(child: _DotGridPainter()),
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l.welcomeBack,
                          style: const TextStyle(
                            color: AppColors.textOnBrandMuted,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 60.ms, duration: 320.ms),
                      ),
                      _TierBadge(tier: member.tier)
                          .animate()
                          .fadeIn(delay: 100.ms, duration: 320.ms)
                          .slideX(begin: 0.2, end: 0, delay: 100.ms, duration: 320.ms, curve: AppMotion.emphasized),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    member.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                      height: 1.1,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 120.ms, duration: 380.ms)
                      .slideY(begin: 0.2, end: 0, delay: 120.ms, duration: 380.ms, curve: AppMotion.springOut)
                      .blur(begin: const Offset(4, 4), end: Offset.zero, delay: 120.ms, duration: 360.ms),
                  const SizedBox(height: AppSpacing.xl),
                  _ClaimsPill(count: member.enquiriesInProgress)
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 320.ms)
                      .slideX(begin: -0.12, end: 0, delay: 200.ms, duration: 360.ms, curve: AppMotion.springOut),
                  const SizedBox(height: AppSpacing.lg),
                  _GlassSharesCard(
                    total: currency.format(member.sharesTotal),
                    asOfDate: DateFormat.yMMMd().format(member.sharesAsOf),
                    monthlyChange: member.monthlyChange,
                    currency: member.sharesCurrency,
                    label: l.totalShares,
                    cta: l.viewStatement,
                    onCta: onViewStatement,
                  )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 420.ms)
                      .slideY(begin: 0.18, end: 0, delay: 300.ms, duration: 440.ms, curve: AppMotion.springOut)
                      .scale(begin: const Offset(0.96, 0.96), delay: 300.ms, duration: 440.ms, curve: AppMotion.springOut),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(0.94, 0.94), duration: 500.ms, curve: AppMotion.springOut);
  }
}

class _TierBadge extends StatelessWidget {
  const _TierBadge({required this.tier});
  final String tier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: Colors.white.withValues(alpha: 0.30), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.workspace_premium_rounded, size: 12, color: Color(0xFFFFD700)),
          const SizedBox(width: 5),
          Text(
            tier,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(6, 6, 14, 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: Colors.white.withValues(alpha: 0.22), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 30,
                height: 30,
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
              const Icon(Icons.chevron_right, color: Colors.white70, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassSharesCard extends StatelessWidget {
  const _GlassSharesCard({
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

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xxl),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.28),
              width: 1.5,
            ),
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
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          total,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.8,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: isUp
                          ? Colors.white.withValues(alpha: 0.18)
                          : Colors.orange.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.20),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isUp ? Icons.trending_up : Icons.trending_down,
                          size: 13,
                          color: isUp ? const Color(0xFF6EE7B7) : const Color(0xFFFBBF24),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          changeStr,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isUp ? const Color(0xFF6EE7B7) : const Color(0xFFFBBF24),
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
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.55),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  DarkPillButton(label: cta, onPressed: onCta, compact: true),
                ],
              ),
            ],
          ),
        ),
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

class _DotGridPainter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _DotPattern(),
        size: Size.infinite,
      ),
    );
  }
}

class _DotPattern extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    const spacing = 22.0;
    const radius = 1.2;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotPattern old) => false;
}
