import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/generated/app_localizations.dart';
import '../../../core/mock/mock_api.dart';
import '../../../core/theme/tokens.dart';
import '../../../core/widgets/soft_icon_button.dart';
import '../widgets/news_card.dart';

class NewsListPage extends ConsumerWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsProvider);
    final l = AppL10n.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.lg),
          child: SoftIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
        leadingWidth: 64,
        title: Text(l.latestNews),
      ),
      body: newsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (items) => ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenPadding,
            AppSpacing.md,
            AppSpacing.screenPadding,
            AppSpacing.huge,
          ),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.lg),
          itemBuilder: (context, i) {
            return NewsCard(item: items[i], width: double.infinity, height: 280)
                .animate()
                .fadeIn(delay: (60 * i).ms, duration: 320.ms)
                .slideY(
                  begin: 0.12,
                  end: 0,
                  delay: (60 * i).ms,
                  duration: 360.ms,
                  curve: AppMotion.emphasized,
                );
          },
        ),
      ),
    );
  }
}
