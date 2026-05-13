// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppL10nEn extends AppL10n {
  AppL10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Koperasi VX';

  @override
  String get tabHome => 'Home';

  @override
  String get tabNews => 'News';

  @override
  String get tabMarket => 'Market';

  @override
  String get tabInbox => 'Inbox';

  @override
  String get tabProfile => 'Profile';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String claimsInProgress(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You have $count enquiries in progress',
      one: 'You have 1 enquiry in progress',
    );
    return '$_temp0';
  }

  @override
  String get totalShares => 'Total Shares';

  @override
  String get viewStatement => 'View Statement';

  @override
  String asOf(String date) {
    return 'as of $date';
  }

  @override
  String get services => 'Services';

  @override
  String get servicePayDues => 'Pay Dues';

  @override
  String get serviceStatements => 'Statements';

  @override
  String get serviceTopUpShares => 'Top-up Shares';

  @override
  String get serviceMarketplace => 'Marketplace';

  @override
  String get serviceEnquiry => 'Enquiry';

  @override
  String get serviceEvents => 'Events';

  @override
  String get latestNews => 'Latest News';

  @override
  String get seeAll => 'See all';

  @override
  String get upcomingEvents => 'Upcoming Events';

  @override
  String minRead(int min) {
    return '$min min read';
  }

  @override
  String publishedOn(String date) {
    return 'Published on $date';
  }

  @override
  String get share => 'Share';

  @override
  String get bookmark => 'Bookmark';

  @override
  String get languageToggle => 'BM';

  @override
  String get memberId => 'Member ID';

  @override
  String get yourMemberCard => 'Your Member Card';
}
