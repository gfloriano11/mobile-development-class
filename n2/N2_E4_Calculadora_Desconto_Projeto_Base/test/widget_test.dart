import 'package:calculadora_desconto/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Calcula desconto pela interface',
    (WidgetTester tester) async {
      await tester.pumpWidget(const DiscountApp());
      await tester.enterText(find.byKey(Key("valueField")), "100");
      await tester.enterText(find.byKey(Key("discountField")), "10");
      await tester.tap(find.byKey(Key("calculateButton")));
      await tester.pump();

      expect(find.text("Valor final: R\$ 90.00"), findsOneWidget);
    },
  );
}
