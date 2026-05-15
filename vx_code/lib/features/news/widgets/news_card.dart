import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/generated/app_localizations.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/mock/models.dart';
import '../../../core/theme/tokens.dart';
import '../../../core/widgets/tag_pill.dart';
import '../detail/news_detail_page.dart';

/// A news item card with an [OpenContainer] container-transform transition.
///
/// Closed state: image gradient with title overlay, tag pill, and metadata row.
/// Opens to [NewsDetailPage] with a full-screen expand animation.
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
        closedBuilder: (context, openContainer) => _ClosedCard(
          item: item,
          localeCode: localeCode,
          minReadLabel: l.minRead(item.minRead),
          onTap: openContainer,
        ),
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
          boxShadow: AppShadows.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area — flex 65
            Expanded(
              flex: 65,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient image with Hero tag
                  Hero(
                    tag: 'news-img-${item.id}',
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
                  // Dark bottom scrim for title legibility
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
                  // Tag pill — top-left
                  Positioned(
                    top: AppSpacing.md,
                    left: AppSpacing.md,
                    child: TagPill(label: item.tag, color: item.tagColor),
                  ),
                  // Title — bottom overlay, white, 14px w700
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
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Meta row — flex 35
            Expanded(
              flex: 35,
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
                    const Spacer(),
                    const Icon(
                      Icons.access_time_rounded,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      minReadLabel,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
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
}
