class Calculator {
  int x;
  int y;
  Calculator({this.x, this.y});

  addNumberToX(int number) {
    x = number + x;
  }

  subNumberToY(int number) {
    y = y - number;
  }

  multiplyXtoY() {
    return x * y;
  }
}
