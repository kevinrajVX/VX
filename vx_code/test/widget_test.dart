import 'package:flutter_test/flutter_test.dart';

import 'package:vx_code/main.dart';

void main() {
  testWidgets('App renders home page', (WidgetTester tester) async {
    await tester.pumpWidget(const VXCodeApp());

    expect(find.text('VX Code'), findsWidgets);
    expect(find.text('Welcome to VX Code'), findsOneWidget);
  });
}
