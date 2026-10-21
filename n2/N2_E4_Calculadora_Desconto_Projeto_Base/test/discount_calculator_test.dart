import 'package:calculadora_desconto/discount_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiscountCalculator', () {
    test('10% de desconto em R\$ 100', () {
      expect(DiscountCalculator.calculate(100, 10), 90);
    });

    test('25% de desconto em R\$ 200', () {
      expect(DiscountCalculator.calculate(200, 25), 150);
    });

    test('0% de desconto em R\$ 50', () {
      expect(DiscountCalculator.calculate(50, 0), 50);
    });
  });
}
