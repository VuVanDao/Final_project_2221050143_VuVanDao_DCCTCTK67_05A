import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/second.dart';
import 'package:frontend/views/manage_view.dart';

void main() {
  testWidgets('Second screen has AppBar and Start button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const Second()));

    expect(find.text('Ứng dụng quản lí sinh viên'), findsOneWidget);

    expect(find.text('Bắt đầu'), findsOneWidget);
  });

  testWidgets('Tapping the "Bắt đầu" button navigates to ManageView',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const Second()));

    await tester.tap(find.text('Bắt đầu'));

    await tester.pumpAndSettle();

    // Kiểm tra xem màn hình ManageView có hiển thị không
    expect(find.byType(ManageView), findsOneWidget);
  });
}
