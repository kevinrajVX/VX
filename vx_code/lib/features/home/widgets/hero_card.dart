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
            // Glow blob — top right
            const Positioned(
              right: -80,
              top: -80,
              child: _GlowBlob(size: 300, color: Color(0x606366F1)),
            ),
            // Glow blob — bottom left
            const Positioned(
              left: -60,
              bottom: -80,
              child: _GlowBlob(size: 240, color: Color(0x504F86DC)),
            ),
            // Dot texture
            Positioned.fill(child: _DotTexture()),
            // Content
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
                  // Top row: welcome + tier
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l.welcomeBack,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ).animate().fadeIn(delay: 60.ms, duration: 300.ms),
                      ),
                      _TierBadge(tier: member.tier)
                          .animate()
                          .fadeIn(delay: 100.ms)
                          .slideX(begin: 0.2, end: 0, delay: 100.ms, duration: 320.ms, curve: AppMotion.emphasized),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Member name
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
                      .fadeIn(delay: 120.ms, duration: 360.ms)
                      .slideY(begin: 0.2, end: 0, delay: 120.ms, duration: 380.ms, curve: AppMotion.springOut),
                  const SizedBox(height: AppSpacing.xl),
                  // Claims pill
                  _ClaimsPill(count: member.enquiriesInProgress)
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 300.ms)
                      .slideX(begin: -0.1, end: 0, delay: 200.ms, duration: 340.ms, curve: AppMotion.springOut),
                  const SizedBox(height: AppSpacing.lg),
                  // Inner shares card
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
        .fadeIn(duration: 380.ms)
        .scale(begin: const Offset(0.94, 0.94), duration: 480.ms, curve: AppMotion.springOut);
  }
}

// ─── Tier badge ─────────────────────────────────────────────────────────────

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
        border: Border.all(color: Colors.white.withValues(alpha: 0.28), width: 1),
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

// ─── Claims pill ─────────────────────────────────────────────────────────────

class _ClaimsPill extends StatelessWidget {
  const _ClaimsPill({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 6, 14, 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
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
          const SizedBox(width: 10),
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
    );
  }
}

// ─── Inner shares card (solid white, matching the reference) ─────────────────

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
    final changeStr = '${isUp ? '+' : '-'}$currency ${monthlyChange.abs().toStringAsFixed(2)}';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: AppShadows.elevated,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: label + decorative illustration
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 6),
                    Text(
                      total,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Decorative abstract illustration — matches the paper/doc in reference
              CustomPaint(
                size: const Size(52, 48),
                painter: _CardIllustrationPainter(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Divider
          Container(height: 1, color: AppColors.divider),
          const SizedBox(height: AppSpacing.md),
          // Bottom row: change indicator + CTA
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: isUp ? AppColors.tagGreenBg : AppColors.tagAmberBg,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isUp ? Icons.trending_up : Icons.trending_down,
                      size: 13,
                      color: isUp ? AppColors.tagGreenText : AppColors.tagAmberText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      changeStr,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isUp ? AppColors.tagGreenText : AppColors.tagAmberText,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              DarkPillButton(label: cta, onPressed: onCta, compact: true, onBrand: true),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Decorative card illustration (like the paper doc in the reference) ───────

class _CardIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Background rounded rect (like a folded document)
    paint.color = const Color(0xFFE8EAF6);
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 0, size.width - 8, size.height - 6),
      const Radius.circular(8),
    );
    canvas.drawRRect(rrect, paint);

    // Folded corner effect
    paint.color = const Color(0xFFD0D3EF);
    final corner = Path()
      ..moveTo(size.width - 8, 0)
      ..lineTo(size.width, 10)
      ..lineTo(size.width - 8, 10)
      ..close();
    canvas.drawPath(corner, paint);

    // Lines inside the doc
    paint.color = const Color(0xFFC5C8E8);
    final linePaint = Paint()
      ..color = const Color(0xFFC5C8E8)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 3; i++) {
      final y = 18.0 + i * 8;
      final endX = i == 2 ? size.width - 22 : size.width - 14;
      canvas.drawLine(Offset(16, y), Offset(endX, y), linePaint);
    }

    // Small chart bars at bottom
    paint.color = AppColors.brandViolet.withValues(alpha: 0.35);
    final barWidths = [6.0, 10.0, 8.0, 12.0];
    var bx = 16.0;
    for (final w in barWidths) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(bx, size.height - 18, w, 8),
          const Radius.circular(2),
        ),
        paint,
      );
      bx += w + 3;
    }
  }

  @override
  bool shouldRepaint(_CardIllustrationPainter old) => false;
}

// ─── Glow blob ───────────────────────────────────────────────────────────────

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

// ─── Dot texture overlay ─────────────────────────────────────────────────────

class _DotTexture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(painter: _DotPattern()),
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
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotPattern old) => false;
}
