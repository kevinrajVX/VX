import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/generated/app_localizations.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/mock/models.dart';
import '../../../core/theme/tokens.dart';
import '../../../core/widgets/tag_pill.dart';
import '../detail/news_detail_page.dart';

class NewsCard extends ConsumerWidget {
  const NewsCard({
    super.key,
    required this.item,
    this.width = 280,
    this.height = 220,
  });

  final NewsItem item;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeCode = ref.watch(localeProvider).languageCode;
    final l = AppL10n.of(context);

    return SizedBox(
      width: width,
      height: height,
      child: OpenContainer(
        closedElevation: 0,
        openElevation: 0,
        closedColor: Colors.transparent,
        openColor: AppColors.background,
        transitionDuration: AppMotion.page,
        transitionType: ContainerTransitionType.fadeThrough,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        closedBuilder: (context, openContainer) {
          return _ClosedCard(
            item: item,
            localeCode: localeCode,
            minReadLabel: l.minRead(item.minRead),
            onTap: openContainer,
          );
        },
        openBuilder: (context, _) => NewsDetailPage(item: item),
      ),
    );
  }
}

class _ClosedCard extends StatelessWidget {
  const _ClosedCard({
    required this.item,
    required this.localeCode,
    required this.minReadLabel,
    required this.onTap,
  });

  final NewsItem item;
  final String localeCode;
  final String minReadLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.elevated,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area — 68% of height
            Expanded(
              flex: 68,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient image
                  Hero(
                    tag: 'news-image-${item.id}',
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: item.gradientColors,
                        ),
                      ),
                    ),
                  ),
                  // Geometric decoration overlay
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _CardDecorationPainter(
                        color: Colors.white.withValues(alpha: 0.07),
                      ),
                    ),
                  ),
                  // Bottom gradient scrim for title legibility
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.3, 1.0],
                          colors: [
                            Colors.black.withValues(alpha: 0),
                            Colors.black.withValues(alpha: 0.68),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Tag pill top-left
                  Positioned(
                    top: AppSpacing.md,
                    left: AppSpacing.md,
                    child: TagPill(label: item.tag, color: item.tagColor),
                  ),
                  // Read time top-right
                  Positioned(
                    top: AppSpacing.md,
                    right: AppSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.30),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 10,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            minReadLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Title overlay
                  Positioned(
                    bottom: AppSpacing.md,
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    child: Text(
                      item.localizedTitle(localeCode),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        letterSpacing: -0.3,
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Meta row
            Expanded(
              flex: 32,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.localizedCategory(localeCode),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      _formatDate(item.publishedAt),
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return '${diff}d ago';
    return '${d.day}/${d.month}';
  }
}

class _CardDecorationPainter extends CustomPainter {
  const _CardDecorationPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Large circle top-right
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.1), 60, paint);
    // Medium circle bottom-left
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.85), 40, paint);
    // Small circle center-right
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.55), 24, paint);
  }

  @override
  bool shouldRepaint(_CardDecorationPainter old) => false;
}
