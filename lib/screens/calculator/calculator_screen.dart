import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/navigationDrawer/main_drawer.dart';
import 'package:kabod_app/screens/calculator/components/calculator.dart';
import 'package:kabod_app/screens/calculator/components/custom_dialog.dart';
import 'package:kabod_app/screens/calculator/components/input_cards.dart';
import 'package:kabod_app/screens/calculator/components/result_card.dart';
import 'package:kabod_app/screens/commons/appbar.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _enteredWeight, _enteredReps;
  Future<Map<int, double>> _estimations;
  static const columnCount = 4;

  void _onRepsChanged(String reps) {
    _enteredReps = reps;
    onDataEntered(_enteredWeight, _enteredReps);
  }

  void _onWeightChanged(String weight) {
    _enteredWeight = weight;
    onDataEntered(_enteredWeight, _enteredReps);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        scaffoldKey: _scaffoldKey,
        title: Text(
          'RM Calculator',
          style: TextStyle(
              color: kTextColor, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        shape: kAppBarShape,
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: MyDrawer(AppRoutes.calculatorRoute),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 45 * MediaQuery.of(context).size.height / 825),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: TextInputCard(
                        cardTitle: "Weight",
                        hintText: "Required",
                        decimal: true,
                        onChanged: _onWeightChanged,
                        text: _enteredWeight)),
                Expanded(
                    child: TextInputCard(
                        cardTitle: "Reps",
                        hintText: "Required",
                        decimal: false,
                        onChanged: _onRepsChanged,
                        text: _enteredReps)),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: _estimations,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container();
                    default:
                      if (snapshot.hasError) {
                        return Center(child: Text("No formula selected"));
                      } else if (snapshot.hasError) {
                        print(
                            "Error on _GridResultsState FutureBuilder: ${snapshot.error}");
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.error),
                              Text(
                                  "Upps, an unxepected error occured. Try again!")
                            ],
                          ),
                        );
                      } else if (!snapshot.hasData) {
                        /* If _estimatedRM is null, it means that entered weight/reps is not valid*/
                        return Center(
                            child: Text(
                          "No Data Available",
                          style: TextStyle(fontSize: 24),
                        ));
                      } else {
                        return GridView.count(
                          crossAxisCount: columnCount,
                          children: List.generate(12, (int index) {
                            /* Once we have the rm, we need to estimate every rep weight */
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              columnCount: columnCount,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: Center(
                                      child: GestureDetector(
                                    onTap: () {
                                      Map platesAndQty = Calculator.pickPlates(
                                          snapshot.data[index + 1]);
                                      List platesToLoad =
                                          platesAndQty.keys.toList();
                                      List allPlatesToLoad =
                                          Calculator.getListOfPlates();
                                      var sum = allPlatesToLoad
                                          .reduce((a, b) => a + b);
                                      var finalSum = (sum * 2) + 45;

                                      List platesQty =
                                          platesAndQty.values.toList();
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomDialogBox(
                                              title:
                                                  "Plates for ${snapshot.data[index + 1].toInt()} lb",
                                              descriptions:
                                                  "Load these plates on each side of a 45lb bar",
                                              text: finalSum !=
                                                      snapshot.data[index + 1]
                                                          .toInt()
                                                  ? 'Note: $finalSum lb is as close as you can get with the plates you have setup.'
                                                  : '',
                                              listOfPlates: Container(
                                                height: 120,
                                                child: ListView.builder(
                                                    itemCount: platesAndQty
                                                        .keys.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Center(
                                                        child: Text(
                                                            '${platesQty[index]} x ${platesToLoad[index].toString()} lb',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 24,
                                                                color:
                                                                    kButtonColor)),
                                                      );
                                                    }),
                                              ),
                                            );
                                          });
                                    },
                                    child: ResultCard(
                                        weight: snapshot.data[index + 1],
                                        reps: index + 1),
                                  )),
                                ),
                              ),
                            );
                          }),
                        );
                      }
                  }
                }),
          )
        ],
      ),
    );
  }

  void updateResults(Future<Map<int, double>> results) {
    setState(() {
      //validEntry = true;
      _estimations = results;
    });
  }

  void onDataEntered(String weight, String reps) {
    double _weight = double.tryParse(weight ?? "");
    int _reps = int.tryParse(reps ?? "");

    if (_weight == null || _reps == null || _weight == 0 || _reps == 0) {
    } else {
      Future<Map<int, double>> estimations =
          Calculator.estimateReps(_weight, _reps, 12);
      updateResults(estimations);
    }
  }
}
