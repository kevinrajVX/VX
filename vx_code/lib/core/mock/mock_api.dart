import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models.dart';

class MockApi {
  Future<Member> fetchMember() async {
    final raw = await rootBundle.loadString('assets/mock/member.json');
    return Member.fromJson(json.decode(raw) as Map<String, dynamic>);
  }

  Future<List<NewsItem>> fetchNews() async {
    final raw = await rootBundle.loadString('assets/mock/news.json');
    final list = json.decode(raw) as List;
    return list
        .map((e) => NewsItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<EventItem>> fetchEvents() async {
    final raw = await rootBundle.loadString('assets/mock/events.json');
    final list = json.decode(raw) as List;
    return list
        .map((e) => EventItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

final mockApiProvider = Provider<MockApi>((ref) => MockApi());

final memberProvider = FutureProvider<Member>((ref) async {
  return ref.read(mockApiProvider).fetchMember();
});

final newsProvider = FutureProvider<List<NewsItem>>((ref) async {
  return ref.read(mockApiProvider).fetchNews();
});

final eventsProvider = FutureProvider<List<EventItem>>((ref) async {
  return ref.read(mockApiProvider).fetchEvents();
});
