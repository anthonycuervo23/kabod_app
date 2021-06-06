import 'package:flutter/material.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/core/repository/results_repository.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:kabod_app/screens/results/edit_results.dart';

//my imports
import 'package:kabod_app/screens/results/model/results_model.dart';
import 'package:kabod_app/screens/wods/model/wod_model.dart';
import 'package:provider/provider.dart';

class PopupWodMenu extends StatefulWidget {
  final Wod currentWod;

  PopupWodMenu({this.currentWod});

  @override
  _PopupWodMenuState createState() => _PopupWodMenuState();
}

class _PopupWodMenuState extends State<PopupWodMenu> {
  List<Result> listOfResults = [];
  Result selectedResult;

  bool checkResult(List<Result> listOfResults) {
    //used inbuilt method
    return listOfResults.any((element) =>
        element.wodName == widget.currentWod.title &&
        isOnSameDate(element.date, widget.currentWod.date));
  }

  bool isOnSameDate(DateTime day1, DateTime day2) {
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }

  currentResult(List<Result> listOfResults) {
    //used inbuilt method
    return listOfResults.elementAt(listOfResults.indexWhere(
        (element) => isOnSameDate(element.date, widget.currentWod.date)));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserRepository user = Provider.of<UserRepository>(context);
    final ResultRepository result = Provider.of<ResultRepository>(context);

    result.getResult(user.user?.uid, widget.currentWod.title);
    listOfResults = result.listOfResults;
    return PopupMenuButton(
      color: kBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all((Radius.circular(10)))),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Column(
            children: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset('assets/icons/results_icon.png'),
                      SizedBox(width: 10),
                      Text(checkResult(listOfResults)
                          ? S.of(context).editScore
                          : S.of(context).addScore),
                    ],
                  ),
                ),
                onTap: () {
                  checkResult(listOfResults)
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EditResultScreen(
                                  currentResult: currentResult(listOfResults))))
                      : Navigator.pushNamed(
                          context, AppRoutes.addWodResultsRoute,
                          arguments: widget.currentWod);
                },
              ),
              user.userModel.admin == true
                  ? Column(
                      children: [
                        Divider(),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset('assets/icons/edit_icon.png'),
                                SizedBox(width: 10),
                                Text(S.of(context).editWod),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.editWodRoute,
                                arguments: widget.currentWod);
                          },
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        )
      ],
      child: Icon(
        Icons.arrow_drop_down_circle,
        size: 40,
        color: kButtonColor,
      ),
    );
  }
}
