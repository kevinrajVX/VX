import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vx_code/main.dart';

void main() {
  testWidgets('App boots', (WidgetTester tester) async {
    await tester.pumpWidget(const VXCodeApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
