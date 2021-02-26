import 'package:flutter/material.dart';

//my imports
import 'package:kabod_app/core/presentation/constants.dart';

class PopupWodMenu extends StatelessWidget {
  const PopupWodMenu({
    Key key,
  }) : super(key: key);

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
                onTap: () {},
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
