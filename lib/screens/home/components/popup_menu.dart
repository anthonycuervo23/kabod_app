import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my imports
import 'package:kabod_app/screens/wods/model/wod_model.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/auth/model/user_repository.dart';

class PopupWodMenu extends StatelessWidget {
  final Wod currentWod;
  PopupWodMenu({this.currentWod});

  @override
  Widget build(BuildContext context) {
    final UserRepository user = Provider.of<UserRepository>(context);
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
                      Text('Add Score'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.addWodResultsRoute,
                      arguments: currentWod);
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
                            arguments: currentWod);
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
