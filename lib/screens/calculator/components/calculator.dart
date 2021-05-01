import 'dart:math';

class Calculator {
  static const Map<String, bool> formulas = {
    "Brzycki": true,
    "McGlothin": true,
    "Lombardi": true,
    "Mayhew et al": true,
    "O'Conner et al": true,
    "Wathen": true
  };

  static Future<Map<int, double>> estimateReps(
      double weight, int reps, int nEstimations) async {
    Map<int, double> estimations = Map();
    double estimatedRM = await estimateRM(weight, reps);
    for (int i = 1; i <= nEstimations; i++) {
      estimations[i] = await estimateWeight(estimatedRM, i);
    }
    return estimations;
  }

  static Future<double> estimateRM(double weight, int reps) async {
    return _estimateMean(weight, reps, _estimateRM);
  }

  static Future<double> estimateWeight(double rm, int reps) async {
    return _estimateMean(rm, reps, _estimateWeight);
  }

  static double _estimateMean(double weight, int reps, Function estimateFunct) {
    double sum = 0;
    int n = 0;

    formulas.forEach((k, v) {
      if (v) {
        n += 1;
        sum += estimateFunct(weight, reps, k);
      }
    });
    return (sum / n).roundToDouble();
  }

  static double _estimateRM(double weight, int reps, String formula) {
    switch (formula) {
      case "Brzycki":
        return weight * 36 / (37 - reps);
      case "McGlothin":
        return 100 * weight / (101.3 - 2.67123 * reps);
      case "Lombardi":
        return weight * pow(reps, 0.1);
      case "Mayhew et al":
        return 100 * weight / (52.2 + 41.9 * pow(e, -0.055 * reps));
      case "O'Conner et al":
        return weight * (1 + reps / 40);
      case "Wathen":
        return 100 * weight / (48.8 + 53.8 * pow(e, -0.075 * reps));
    }
  }

  static double _estimateWeight(double rm, int reps, String formula) {
    switch (formula) {
      case "Brzycki":
        return rm * (37 - reps) / 36;
      case "McGlothin":
        return rm * (101.3 - 2.67123 * reps) / 100;
      case "Lombardi":
        return rm / pow(reps, 0.1);
      case "Mayhew et al":
        return rm * (52.2 + 41.9 * pow(e, -0.055 * reps)) / 100;
      case "O'Conner et al":
        return rm / (1 + reps / 40);
      case "Wathen":
        return rm * (48.8 + 53.8 * pow(e, -0.075 * reps)) / 100;
    }
  }

  static List _platesOnBar = [];

  static Map pickPlates(weight) {
    List platesOnBar = [];
    List plateStandard = [45, 35, 25, 15, 5, 2.5];
    double weightToAdd = (weight - 45) / 2;
    var mapOfPlates = Map();
    for (var plate in plateStandard) {
      while (weightToAdd >= plate) {
        platesOnBar.add(plate);
        weightToAdd -= plate;
      }
    }
    _platesOnBar = platesOnBar;
    platesOnBar.forEach((plate) {
      if (!mapOfPlates.containsKey(plate)) {
        mapOfPlates[plate] = 1;
      } else {
        mapOfPlates[plate] += 1;
      }
    });
    return mapOfPlates;
  }

  static List getListOfPlates() {
    return _platesOnBar;
  }
}
