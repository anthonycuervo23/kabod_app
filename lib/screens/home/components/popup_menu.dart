import 'package:flutter/material.dart';
import 'package:kabod_app/screens/home/model/wod_model.dart';

//my imports
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class PopupWodMenu extends StatelessWidget {
  final Wod currentWod;
  PopupWodMenu({this.currentWod});

  @override
  Widget build(BuildContext context) {
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
                onTap: () {},
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
              InkWell(
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
              ),
            ],
          ),
        )
      ],
      child: Icon(
        Icons.add_box,
        size: 40,
        color: kButtonColor,
      ),
    );
  }
}
