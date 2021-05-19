import 'package:kabod_app/functions/calculator_class.dart';
import 'package:test/test.dart';

void main() {
  test("testing addNumberToX", () {
    Calculator calculator = Calculator(x: 3, y: 2);

    calculator.addNumberToX(5);

    expect(calculator.x, 8);
  });

  test("testing subNumberToY", () {
    Calculator calculator = Calculator(x: 5, y: 7);

    calculator.subNumberToY(3);

    expect(calculator.y, 4);
  });

  test("testing multiply x and y", () {
    Calculator calculator = Calculator(x: 4, y: 6);

    var result = calculator.multiplyXtoY();

    expect(result, 24);
  });

  test("testing the whole class", () {
    Calculator calculator = Calculator(x: 3, y: 5);

    calculator.addNumberToX(7);
    calculator.subNumberToY(2);
    var result = calculator.multiplyXtoY();

    expect(calculator.x, 10);
    expect(calculator.y, 3);
    expect(result, 30);
  });
}
