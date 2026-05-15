import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/localization/generated/app_localizations.dart';
import 'core/localization/locale_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_shell.dart';

void main() {
  runApp(const ProviderScope(child: VXCodeApp()));
}

/// Root application widget.
///
/// Watches [localeProvider] to switch between English and Malay at runtime.
/// Uses [AppTheme.light()] for Material 3 theming with Plus Jakarta Sans +
/// Space Grotesk typography.
class VXCodeApp extends ConsumerWidget {
  const VXCodeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return MaterialApp(
      title: 'Koperasi VX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      locale: locale,
      supportedLocales: const [Locale('en'), Locale('ms')],
      localizationsDelegates: const [
        AppL10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeShell(),
    );
  }
}
