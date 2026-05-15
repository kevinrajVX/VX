import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/generated/app_localizations.dart';
import '../../core/theme/tokens.dart';
import '../../core/widgets/pressable.dart';
import '../news/list/news_list_page.dart';
import 'home_tab.dart';
import 'placeholder_tab.dart';

/// Root shell widget that manages the 5-tab bottom navigation.
///
/// Uses an [IndexedStack] so each tab preserves its state when switching.
/// The bottom nav bar uses [Pressable] + [AnimatedContainer] for smooth
/// selection transitions with icon swap via [AnimatedSwitcher].
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
        view: PlaceholderTab(label: l.tabMarket, icon: Icons.storefront_outlined),
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
        view: PlaceholderTab(label: l.tabProfile, icon: Icons.person_outline_rounded),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: IndexedStack(
        index: _index,
        children: tabs.map((t) => t.view).toList(),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(color: AppColors.divider, width: 0.5),
            ),
            boxShadow: AppShadows.soft,
          ),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            AppSpacing.sm,
            AppSpacing.sm,
            AppSpacing.xs,
          ),
          child: Row(
            children: List.generate(tabs.length, (i) {
              final selected = i == _index;
              final tab = tabs[i];
              return Expanded(
                child: Pressable(
                  onTap: () => setState(() => _index = i),
                  pressedScale: 0.90,
                  child: AnimatedContainer(
                    duration: AppMotion.base,
                    curve: AppMotion.emphasized,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.brandViolet.withValues(alpha: 0.10)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSwitcher(
                          duration: AppMotion.fast,
                          transitionBuilder: (child, anim) => ScaleTransition(
                            scale: Tween<double>(begin: 0.75, end: 1.0).animate(
                              CurvedAnimation(
                                parent: anim,
                                curve: AppMotion.spring,
                              ),
                            ),
                            child: child,
                          ),
                          child: Icon(
                            selected ? tab.icon : tab.iconOutline,
                            key: ValueKey(selected),
                            size: 24,
                            color: selected
                                ? AppColors.brandViolet
                                : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        AnimatedDefaultTextStyle(
                          duration: AppMotion.fast,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                selected ? FontWeight.w700 : FontWeight.w500,
                            color: selected
                                ? AppColors.brandViolet
                                : AppColors.textSecondary,
                          ),
                          child: Text(tab.label),
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
  const _TabSpec({
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
