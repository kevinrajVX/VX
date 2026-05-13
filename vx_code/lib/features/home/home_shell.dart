import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/generated/app_localizations.dart';
import '../../core/theme/tokens.dart';
import '../../core/widgets/pressable.dart';
import '../news/list/news_list_page.dart';
import 'home_tab.dart';
import 'placeholder_tab.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    final tabs = [
      _TabSpec(
        label: l.tabHome,
        icon: Icons.home_rounded,
        iconOutline: Icons.home_outlined,
        view: const HomeTab(),
      ),
      _TabSpec(
        label: l.tabNews,
        icon: Icons.article_rounded,
        iconOutline: Icons.article_outlined,
        view: const NewsListPage(),
      ),
      _TabSpec(
        label: l.tabMarket,
        icon: Icons.storefront_rounded,
        iconOutline: Icons.storefront_outlined,
        view: PlaceholderTab(
          label: l.tabMarket,
          icon: Icons.storefront_outlined,
        ),
      ),
      _TabSpec(
        label: l.tabInbox,
        icon: Icons.inbox_rounded,
        iconOutline: Icons.inbox_outlined,
        view: PlaceholderTab(label: l.tabInbox, icon: Icons.inbox_outlined),
      ),
      _TabSpec(
        label: l.tabProfile,
        icon: Icons.person_rounded,
        iconOutline: Icons.person_outline_rounded,
        view: PlaceholderTab(
          label: l.tabProfile,
          icon: Icons.person_outline_rounded,
        ),
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: tabs.map((t) => t.view).toList(),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            boxShadow: AppShadows.soft,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: List.generate(tabs.length, (i) {
              final selected = i == _index;
              final tab = tabs[i];
              return Expanded(
                child: Pressable(
                  onTap: () => setState(() => _index = i),
                  pressedScale: 0.94,
                  child: AnimatedContainer(
                    duration: AppMotion.base,
                    curve: AppMotion.emphasized,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSwitcher(
                          duration: AppMotion.fast,
                          transitionBuilder: (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
                          child: Icon(
                            selected ? tab.icon : tab.iconOutline,
                            key: ValueKey(selected),
                            size: 24,
                            color: selected
                                ? AppColors.brandViolet
                                : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tab.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: selected
                                ? AppColors.brandViolet
                                : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: AppMotion.base,
                          curve: AppMotion.emphasized,
                          height: 3,
                          width: selected ? 18 : 0,
                          decoration: BoxDecoration(
                            color: AppColors.brandViolet,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _TabSpec {
  _TabSpec({
    required this.label,
    required this.icon,
    required this.iconOutline,
    required this.view,
  });
  final String label;
  final IconData icon;
  final IconData iconOutline;
  final Widget view;
}
