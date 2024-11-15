import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/update_view.dart';
import 'package:frontend/models/manage_model.dart';

void main() {
  group('UpdateView Widget Tests', () {
    late ManageModel testItem;

    setUp(() {
      testItem = ManageModel(
          msv: 2221050143,
          ten: "Van Dao",
          lop: "CNPM E2",
          gpa: 3.6,
          diemdanh: true);
    });

    testWidgets('displays initial data and updates correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: UpdateView(item: testItem),
        ),
      );

      expect(find.text('Van Dao'), findsOneWidget);
      expect(find.text('CNPM E2'), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Lưu'));
      await tester.pumpAndSettle();

      // Verify if the values in testItem are updated correctly
      expect(testItem.lop, 'CNPM E2');
      expect(testItem.ten, 'Van Dao');
    });
  });
}
