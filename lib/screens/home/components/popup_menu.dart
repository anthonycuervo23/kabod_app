import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my imports
import 'package:kabod_app/screens/results/model/results_model.dart';
import 'package:kabod_app/core/repository/results_repository.dart';
import 'package:kabod_app/screens/results/edit_results.dart';
import 'package:kabod_app/screens/wods/model/wod_model.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/repository/user_repository.dart';

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
    for (var i = 0; i < listOfResults.length; i++) {
      if (listOfResults[i].wodName == widget.currentWod.title) {
        return true;
      }
    }
    return false;
  }

  currentResult(List<Result> listOfResults) {
    for (var i = 0; i < listOfResults.length; i++) {
      if (listOfResults[i].wodName == widget.currentWod.title) {
        return listOfResults[i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserRepository user = Provider.of<UserRepository>(context);
    final ResultRepository result = Provider.of<ResultRepository>(context);
    result.getResult(user.user.uid, widget.currentWod.title);
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
                          ? 'Edit Score'
                          : 'Add Score'),
                    ],
                  ),
                ),
                onTap: () {
                  checkResult(listOfResults)
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EditResultScreen(
                                  currentResult: currentResult(listOfResults),
                                  currentWod: widget.currentWod)))
                      : Navigator.pushNamed(
                          context, AppRoutes.addWodResultsRoute,
                          arguments: widget.currentWod);
                },
              ),
              Divider(),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset('assets/icons/timer_icon.png'),
                      SizedBox(width: 10),
                      Text('Start Timer'),
                    ],
                  ),
                ),
                onTap: () {},
              ),
              Divider(),
              user.userModel.admin == true
                  ? InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset('assets/icons/edit_icon.png'),
                            SizedBox(width: 10),
                            Text('Edit WOD'),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.editWodRoute,
                            arguments: widget.currentWod);
                      },
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
