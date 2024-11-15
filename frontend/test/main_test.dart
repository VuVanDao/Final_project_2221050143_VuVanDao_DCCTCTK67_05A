import 'package:flutter/material.dart';

import 'package:frontend/views/manage_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';
import 'package:frontend/second.dart';

void main() {
  testWidgets('MainApp khởi chạy và hiển thị Second',
      (WidgetTester tester) async {
    // Xây dựng ứng dụng
    await tester.pumpWidget(const MainApp());

    // Kiểm tra xem Second được hiển thị
    expect(find.byType(Second), findsOneWidget);
  });
}
