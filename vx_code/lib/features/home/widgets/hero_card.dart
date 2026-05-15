import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../../../core/localization/generated/app_localizations.dart';
import '../../../core/mock/models.dart';
import '../../../core/theme/tokens.dart';
import '../../../core/widgets/dark_pill_button.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.member,
    required this.onViewStatement,
  });

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
            // Vivid blue glow — top-right (the electric blue in image 2)
            const Positioned(
              right: -60,
              top: -60,
              child: _GlowBlob(size: 300, color: Color(0x881A56DB)),
            ),
            // Soft white glow — center-top (creates the lens/highlight effect)
            const Positioned(
              right: 40,
              top: 20,
              child: _GlowBlob(size: 140, color: Color(0x55FFFFFF)),
            ),
            // Silver/blue glow — bottom-left
            const Positioned(
              left: -40,
              bottom: -40,
              child: _GlowBlob(size: 220, color: Color(0x40A0B8D8)),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xxxl,
                AppSpacing.xl,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Welcome text — centered
                  Text(
                    l.welcomeBack,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                  ).animate().fadeIn(delay: 60.ms, duration: 320.ms),
                  const SizedBox(height: 6),
                  // Name — centered, large
                  Text(
                    member.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.0,
                      height: 1.1,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 100.ms, duration: 360.ms)
                      .slideY(
                        begin: 0.15,
                        end: 0,
                        delay: 100.ms,
                        duration: 400.ms,
                        curve: AppMotion.springOut,
                      ),
                  const SizedBox(height: AppSpacing.xxl),
                  // Claims pill — white, full width
                  _ClaimsPill(count: member.enquiriesInProgress)
                      .animate()
                      .fadeIn(delay: 180.ms, duration: 300.ms)
                      .slideY(
                        begin: 0.1,
                        end: 0,
                        delay: 180.ms,
                        duration: 340.ms,
                        curve: AppMotion.emphasized,
                      ),
                  const SizedBox(height: AppSpacing.md),
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
                      .fadeIn(delay: 260.ms, duration: 400.ms)
                      .slideY(
                        begin: 0.15,
                        end: 0,
                        delay: 260.ms,
                        duration: 440.ms,
                        curve: AppMotion.springOut,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 360.ms)
        .scale(
          begin: const Offset(0.96, 0.96),
          duration: 460.ms,
          curve: AppMotion.springOut,
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
      padding: const EdgeInsets.fromLTRB(6, 6, 16, 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 20,
            offset: const Offset(0, 6),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Row(
        children: [
          // Colored badge
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.brandViolet,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$count',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l.claimsInProgress(count),
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 20,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

// ─── Inner shares card ────────────────────────────────────────────────────────

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
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: AppShadows.elevated,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upper section: title + illustration
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 13,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'as of $asOfDate',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Large document illustration — matches the reference
                SizedBox(
                  width: 80,
                  height: 72,
                  child: CustomPaint(painter: _DocIllustration()),
                ),
              ],
            ),
          ),
          // Divider
          const Divider(height: 1, thickness: 1, color: AppColors.divider),
          // Lower section: amount + CTA
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        total,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: isUp
                              ? AppColors.tagGreenBg
                              : AppColors.tagAmberBg,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isUp
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              size: 11,
                              color: isUp
                                  ? AppColors.tagGreenText
                                  : AppColors.tagAmberText,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              changeStr,
                              style: TextStyle(
                                fontSize: 10,
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
                ),
                DarkPillButton(label: cta, onPressed: onCta, compact: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Document illustration (CustomPainter) ────────────────────────────────────

class _DocIllustration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..color = const Color(0xFFEEF0F7)
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = const Color(0xFFDDE0ED)
      ..style = PaintingStyle.fill;

    // Back page (shadow page)
    final backPage = RRect.fromRectAndRadius(
      Rect.fromLTWH(10, 6, size.width - 18, size.height - 10),
      const Radius.circular(10),
    );
    canvas.drawRRect(backPage, shadowPaint);

    // Main page
    final mainPage = RRect.fromRectAndRadius(
      Rect.fromLTWH(2, 0, size.width - 12, size.height - 8),
      const Radius.circular(10),
    );
    canvas.drawRRect(mainPage, bgPaint);

    // Lines on the page
    final linePaint = Paint()
      ..color = const Color(0xFFCDD1E4)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final lineStarts = [14.0, 22.0, 30.0];
    final lineEnds = [size.width - 20, size.width - 26, size.width - 32];
    for (var i = 0; i < lineStarts.length; i++) {
      canvas.drawLine(
        Offset(8, lineStarts[i]),
        Offset(lineEnds[i], lineStarts[i]),
        linePaint,
      );
    }

    // Small bar chart at bottom
    final barPaint = Paint()
      ..color = AppColors.brandViolet.withValues(alpha: 0.30)
      ..style = PaintingStyle.fill;

    final barHeights = [10.0, 16.0, 12.0, 18.0];
    var bx = 8.0;
    const barWidth = 7.0;
    final baseY = size.height - 10.0;
    for (final h in barHeights) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(bx, baseY - h, barWidth, h),
          const Radius.circular(2),
        ),
        barPaint,
      );
      bx += barWidth + 3;
    }
  }

  @override
  bool shouldRepaint(_DocIllustration old) => false;
}

// ─── Glow blob ────────────────────────────────────────────────────────────────

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
