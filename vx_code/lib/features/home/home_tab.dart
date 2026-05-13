import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/localization/generated/app_localizations.dart';
import '../../core/localization/locale_provider.dart';
import '../../core/mock/mock_api.dart';
import '../../core/mock/models.dart';
import '../../core/theme/tokens.dart';
import '../../core/widgets/koperasi_logo.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/soft_icon_button.dart';
import '../../core/widgets/tag_pill.dart';
import '../news/list/news_list_page.dart';
import '../news/widgets/news_card.dart';
import 'widgets/hero_card.dart';
import 'widgets/services_grid.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberAsync = ref.watch(memberProvider);
    final newsAsync = ref.watch(newsProvider);
    final eventsAsync = ref.watch(eventsProvider);
    final l = AppL10n.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.brandViolet,
        onRefresh: () async {
          ref.invalidate(memberProvider);
          ref.invalidate(newsProvider);
          ref.invalidate(eventsProvider);
          await Future.delayed(const Duration(milliseconds: 600));
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(child: SafeArea(child: _TopBar())),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.sm,
                AppSpacing.screenPadding,
                AppSpacing.huge,
              ),
              sliver: SliverList.list(
                children: [
                  memberAsync.when(
                    loading: () => const _HeroSkeleton(),
                    error: (e, _) => _ErrorBox(message: '$e'),
                    data: (m) => HeroCard(
                      member: m,
                      onViewStatement: () {},
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                  SectionHeader(title: l.services),
                  const SizedBox(height: AppSpacing.lg),
                  ServicesGrid(onServiceTap: (_) {}),
                  const SizedBox(height: AppSpacing.xxxl),
                  SectionHeader(
                    title: l.latestNews,
                    actionLabel: l.seeAll,
                    onAction: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const NewsListPage(),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  newsAsync.when(
                    loading: () => const _NewsRowSkeleton(),
                    error: (e, _) => _ErrorBox(message: '$e'),
                    data: (items) => SizedBox(
                      height: 240,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: items.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: AppSpacing.md),
                        itemBuilder: (context, i) {
                          return NewsCard(item: items[i])
                              .animate()
                              .fadeIn(
                                delay: (50 * i).ms,
                                duration: 280.ms,
                              )
                              .slideX(
                                begin: 0.08,
                                end: 0,
                                delay: (50 * i).ms,
                                duration: 320.ms,
                                curve: AppMotion.emphasized,
                              );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                  SectionHeader(title: l.upcomingEvents),
                  const SizedBox(height: AppSpacing.lg),
                  eventsAsync.when(
                    loading: () => const _EventsSkeleton(),
                    error: (e, _) => _ErrorBox(message: '$e'),
                    data: (items) => Column(
                      children: [
                        for (var i = 0; i < items.length; i++) ...[
                          _EventRow(item: items[i])
                              .animate()
                              .fadeIn(delay: (60 * i).ms, duration: 280.ms)
                              .slideY(
                                begin: 0.1,
                                end: 0,
                                delay: (60 * i).ms,
                                duration: 320.ms,
                                curve: AppMotion.emphasized,
                              ),
                          if (i < items.length - 1)
                            const SizedBox(height: AppSpacing.md),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final l = AppL10n.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.md,
        AppSpacing.screenPadding,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          const KoperasiLogo(size: 40, showWordmark: true),
          const Spacer(),
          Pressable(
            onTap: () => ref.read(localeProvider.notifier).toggle(),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                boxShadow: AppShadows.card,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.language,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    locale.languageCode == 'en' ? 'EN · ${l.languageToggle}' : 'BM · ${l.languageToggle}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          SoftIconButton(
            icon: Icons.notifications_none_rounded,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _EventRow extends ConsumerWidget {
  const _EventRow({required this.item});
  final EventItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider).languageCode;
    final day = DateFormat('d').format(item.date);
    final month = DateFormat.MMM(locale).format(item.date).toUpperCase();

    return Pressable(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: item.gradientColors,
                ),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    month,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TagPill(label: item.tag, color: item.tagColor),
                  const SizedBox(height: 6),
                  Text(
                    item.localizedTitle(locale),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.place_outlined,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${item.localizedVenue(locale)} · ${item.time}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSkeleton extends StatelessWidget {
  const _HeroSkeleton();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        color: AppColors.shimmer,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
    );
  }
}

class _NewsRowSkeleton extends StatelessWidget {
  const _NewsRowSkeleton();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Row(
        children: List.generate(
          2,
          (_) => Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: Container(
              width: 280,
              decoration: BoxDecoration(
                color: AppColors.shimmer,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EventsSkeleton extends StatelessWidget {
  const _EventsSkeleton();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (_) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Container(
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.shimmer,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.tagAmberBg,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Text(
        message,
        style: const TextStyle(color: AppColors.tagAmberText),
      ),
    );
  }
}
