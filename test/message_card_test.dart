import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vendoo/models/messages.dart';
import 'package:vendoo/widgets/message_card.dart';

void main() {
  // Widget Test for MessageCard
  testWidgets('MessageCard UI Test', (WidgetTester tester) async {
    final Message testMessage = Message(
      fromId: '1', // adjust these parameters as per your Message model
      msg: 'Test message',
      type: Type.text,
      sent: DateTime.now().toString(),
      read: '',
      toId: ''
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageCard(
            message: testMessage,
          ),
        ),
      ),
    );

    expect(find.byType(MessageCard), findsOneWidget);
    expect(find.text('Test message'), findsOneWidget);

    // Test if long press on the card opens the bottom sheet
    await tester.longPress(find.byType(InkWell));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);

    // Close bottom sheet
    tester.binding.focusManager.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
  });
}