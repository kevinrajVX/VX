import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../../../core/localization/generated/app_localizations.dart';
import '../../../core/mock/models.dart';
import '../../../core/theme/tokens.dart';
import '../../../core/widgets/dark_pill_button.dart';
import '../../../core/widgets/soft_icon_button.dart';

/// The hero card shown at the top of the home screen.
///
/// Full-bleed: squared top corners (flush with screen top), rounded bottom corners.
/// Background is the actual gradient image asset (blue → silver → white).
/// Notification bell is overlaid in the top-right, inside SafeArea.
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
    final currencyFmt = NumberFormat.currency(
      locale: 'ms_MY',
      symbol: '${member.sharesCurrency} ',
      decimalDigits: 2,
    );
    final asOfDate = DateFormat.yMMMd().format(member.sharesAsOf);

    const bottomRadius = BorderRadius.only(
      bottomLeft: Radius.circular(AppRadius.card),
      bottomRight: Radius.circular(AppRadius.card),
    );

    return ClipRRect(
      borderRadius: bottomRadius,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A4FBF),
          image: DecorationImage(
            image: AssetImage('assets/images/hero_bg.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: [

            // Notification bell — top-right, clears status bar via viewPadding
            Builder(
              builder: (context) {
                final top = MediaQuery.of(context).viewPadding.top;
                return Positioned(
                  top: top + 4,
                  right: 8,
                  child: SoftIconButton(
                    icon: Icons.notifications_none_rounded,
                    onPressed: () {},
                  ).animate().fadeIn(delay: 40.ms, duration: 280.ms),
                );
              },
            ),

            // Main content — uses viewPadding so background fills behind status bar
            Builder(
              builder: (context) {
                final topInset = MediaQuery.of(context).viewPadding.top;
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    topInset + AppSpacing.xxxl,
                    AppSpacing.xl,
                    AppSpacing.xl,
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Welcome label
                    Text(
                      l.welcomeBack,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate().fadeIn(delay: 60.ms, duration: 320.ms),

                    const SizedBox(height: 6),

                    // Member name
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

                    // Claims pill
                    _ClaimsPill(count: member.enquiriesInProgress)
                        .animate()
                        .fadeIn(delay: 180.ms, duration: 300.ms)
                        .slideY(
                          begin: 0.10,
                          end: 0,
                          delay: 180.ms,
                          duration: 340.ms,
                          curve: AppMotion.emphasized,
                        ),

                    const SizedBox(height: AppSpacing.md),

                    // Inner shares card
                    _SharesCard(
                      totalFormatted: currencyFmt.format(member.sharesTotal),
                      asOfDate: asOfDate,
                      monthlyChange: member.monthlyChange,
                      currency: member.sharesCurrency,
                      sharesLabel: l.totalShares,
                      ctaLabel: l.viewStatement,
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
                        )
                        .scale(
                          begin: const Offset(0.96, 0.96),
                          delay: 260.ms,
                          duration: 440.ms,
                          curve: AppMotion.springOut,
                        ),
                  ],
                ),
              );
              },
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 360.ms)
        .scale(
          begin: const Offset(0.97, 0.97),
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
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: AppColors.brandViolet,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$count',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l.claimsInProgress(count),
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
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
    required this.totalFormatted,
    required this.asOfDate,
    required this.monthlyChange,
    required this.currency,
    required this.sharesLabel,
    required this.ctaLabel,
    required this.onCta,
  });

  final String totalFormatted;
  final String asOfDate;
  final double monthlyChange;
  final String currency;
  final String sharesLabel;
  final String ctaLabel;
  final VoidCallback onCta;

  @override
  Widget build(BuildContext context) {
    final isUp = monthlyChange >= 0;
    final changeStr =
        '${isUp ? '+' : '-'}$currency ${monthlyChange.abs().toStringAsFixed(2)}';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.hero,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        sharesLabel,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        sharesLabel,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
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
                const SizedBox(width: AppSpacing.md),
                SizedBox(
                  width: 84,
                  height: 76,
                  child: CustomPaint(painter: _DocIllustration()),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.divider),
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
                        totalFormatted,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
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
                                  ? Icons.trending_up_rounded
                                  : Icons.trending_down_rounded,
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
                DarkPillButton(
                  label: ctaLabel,
                  onPressed: onCta,
                  compact: true,
                  onBrand: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Document illustration (CustomPainter) ───────────────────────────────────

class _DocIllustration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backPaint = Paint()
      ..color = const Color(0xFFE0E4F0)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(10, 6, size.width - 18, size.height - 10),
        const Radius.circular(10),
      ),
      backPaint,
    );

    final frontPaint = Paint()
      ..color = const Color(0xFFEEF0F7)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2, 0, size.width - 12, size.height - 8),
        const Radius.circular(10),
      ),
      frontPaint,
    );

    final linePaint = Paint()
      ..color = const Color(0xFFCDD1E4)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    const lineYs = [14.0, 22.0, 30.0];
    for (var i = 0; i < lineYs.length; i++) {
      final endX = size.width - 20.0 - (i * 6.0);
      canvas.drawLine(
        Offset(8, lineYs[i]),
        Offset(endX, lineYs[i]),
        linePaint,
      );
    }

    final barPaint = Paint()
      ..color = AppColors.brandViolet.withValues(alpha: 0.30)
      ..style = PaintingStyle.fill;

    const barHeights = [10.0, 16.0, 12.0, 18.0];
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
