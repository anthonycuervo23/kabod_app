import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//My imports
import 'package:kabod_app/core/repository/wod_repository.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class DeleteWodButton extends StatelessWidget {
  final String currentWodId;
  const DeleteWodButton({
    this.currentWodId,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('assets/icons/trash_icon.png'),
      onPressed: () async {
        final confirm = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: kBackgroundColor,
                title: Text('Warning!',
                    style: TextStyle(
                        color: kButtonColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                content: Text('Are you sure you want to delete this WOD?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                          color: kButtonColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ) ??
            false;
        if (confirm) {
          await context.read<WodRepository>().deleteWod(currentWodId);
          Navigator.pop(context);
        }
      },
    );
  }
}
