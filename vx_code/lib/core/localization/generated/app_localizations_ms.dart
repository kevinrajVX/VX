// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppL10nMs extends AppL10n {
  AppL10nMs([String locale = 'ms']) : super(locale);

  @override
  String get appName => 'Koperasi VX';

  @override
  String get tabHome => 'Utama';

  @override
  String get tabNews => 'Berita';

  @override
  String get tabMarket => 'Pasar';

  @override
  String get tabInbox => 'Peti';

  @override
  String get tabProfile => 'Profil';

  @override
  String get welcomeBack => 'Selamat Kembali';

  @override
  String claimsInProgress(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Anda ada $count pertanyaan dalam proses',
      one: 'Anda ada 1 pertanyaan dalam proses',
    );
    return '$_temp0';
  }

  @override
  String get totalShares => 'Jumlah Syer';

  @override
  String get viewStatement => 'Lihat Penyata';

  @override
  String asOf(String date) {
    return 'pada $date';
  }

  @override
  String get services => 'Perkhidmatan';

  @override
  String get servicePayDues => 'Bayar Yuran';

  @override
  String get serviceStatements => 'Penyata';

  @override
  String get serviceTopUpShares => 'Tambah Syer';

  @override
  String get serviceMarketplace => 'Pasar Raya';

  @override
  String get serviceEnquiry => 'Pertanyaan';

  @override
  String get serviceEvents => 'Acara';

  @override
  String get latestNews => 'Berita Terkini';

  @override
  String get seeAll => 'Lihat semua';

  @override
  String get upcomingEvents => 'Acara Akan Datang';

  @override
  String minRead(int min) {
    return '$min min bacaan';
  }

  @override
  String publishedOn(String date) {
    return 'Diterbitkan pada $date';
  }

  @override
  String get share => 'Kongsi';

  @override
  String get bookmark => 'Simpan';

  @override
  String get languageToggle => 'EN';

  @override
  String get memberId => 'ID Ahli';

  @override
  String get yourMemberCard => 'Kad Ahli Anda';
}
