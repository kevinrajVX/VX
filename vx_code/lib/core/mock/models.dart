import 'package:flutter/material.dart';

class Member {
  Member({
    required this.id,
    required this.name,
    required this.tier,
    required this.sharesTotal,
    required this.sharesCurrency,
    required this.sharesAsOf,
    required this.monthlyChange,
    required this.enquiriesInProgress,
  });

  final String id;
  final String name;
  final String tier;
  final double sharesTotal;
  final String sharesCurrency;
  final DateTime sharesAsOf;
  final double monthlyChange;
  final int enquiriesInProgress;

  factory Member.fromJson(Map<String, dynamic> json) {
    final shares = json['shares'] as Map<String, dynamic>;
    return Member(
      id: json['id'] as String,
      name: json['name'] as String,
      tier: json['tier'] as String,
      sharesTotal: (shares['total'] as num).toDouble(),
      sharesCurrency: shares['currency'] as String,
      sharesAsOf: DateTime.parse(shares['asOf'] as String),
      monthlyChange: (shares['monthlyChange'] as num).toDouble(),
      enquiriesInProgress: json['enquiriesInProgress'] as int,
    );
  }
}

enum TagColor { violet, blue, amber, green }

TagColor _parseTagColor(String value) {
  switch (value) {
    case 'blue':
      return TagColor.blue;
    case 'amber':
      return TagColor.amber;
    case 'green':
      return TagColor.green;
    case 'violet':
    default:
      return TagColor.violet;
  }
}

class NewsItem {
  NewsItem({
    required this.id,
    required this.title,
    required this.titleMs,
    required this.category,
    required this.categoryMs,
    required this.summary,
    required this.summaryMs,
    required this.body,
    required this.bodyMs,
    required this.gradientColors,
    required this.tag,
    required this.tagColor,
    required this.minRead,
    required this.publishedAt,
    required this.author,
  });

  final String id;
  final String title;
  final String titleMs;
  final String category;
  final String categoryMs;
  final String summary;
  final String summaryMs;
  final String body;
  final String bodyMs;
  final List<Color> gradientColors;
  final String tag;
  final TagColor tagColor;
  final int minRead;
  final DateTime publishedAt;
  final String author;

  String localizedTitle(String locale) => locale == 'ms' ? titleMs : title;
  String localizedCategory(String locale) =>
      locale == 'ms' ? categoryMs : category;
  String localizedSummary(String locale) =>
      locale == 'ms' ? summaryMs : summary;
  String localizedBody(String locale) => locale == 'ms' ? bodyMs : body;

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    final gradient = (json['imageGradient'] as List)
        .cast<String>()
        .map(_hexToColor)
        .toList();
    return NewsItem(
      id: json['id'] as String,
      title: json['title'] as String,
      titleMs: json['titleMs'] as String,
      category: json['category'] as String,
      categoryMs: json['categoryMs'] as String,
      summary: json['summary'] as String,
      summaryMs: json['summaryMs'] as String,
      body: json['body'] as String,
      bodyMs: json['bodyMs'] as String,
      gradientColors: gradient,
      tag: json['tag'] as String,
      tagColor: _parseTagColor(json['tagColor'] as String),
      minRead: json['minRead'] as int,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      author: json['author'] as String,
    );
  }
}

class EventItem {
  EventItem({
    required this.id,
    required this.title,
    required this.titleMs,
    required this.date,
    required this.time,
    required this.venue,
    required this.venueMs,
    required this.tag,
    required this.tagColor,
    required this.gradientColors,
  });

  final String id;
  final String title;
  final String titleMs;
  final DateTime date;
  final String time;
  final String venue;
  final String venueMs;
  final String tag;
  final TagColor tagColor;
  final List<Color> gradientColors;

  String localizedTitle(String locale) => locale == 'ms' ? titleMs : title;
  String localizedVenue(String locale) => locale == 'ms' ? venueMs : venue;

  factory EventItem.fromJson(Map<String, dynamic> json) {
    final gradient = (json['imageGradient'] as List)
        .cast<String>()
        .map(_hexToColor)
        .toList();
    return EventItem(
      id: json['id'] as String,
      title: json['title'] as String,
      titleMs: json['titleMs'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      venue: json['venue'] as String,
      venueMs: json['venueMs'] as String,
      tag: json['tag'] as String,
      tagColor: _parseTagColor(json['tagColor'] as String),
      gradientColors: gradient,
    );
  }
}

Color _hexToColor(String hex) {
  final clean = hex.replaceAll('#', '');
  final value = int.parse(clean, radix: 16);
  return Color(0xFF000000 | value);
}
