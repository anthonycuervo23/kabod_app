import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/repository/results_repository.dart';
import 'package:kabod_app/core/repository/user_repository.dart';

class DeleteResultButton extends StatelessWidget {
  final String currentResultId;
  const DeleteResultButton({
    this.currentResultId,
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
                content: Text('Are you sure you want to delete this Result?'),
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
          await context.read<ResultRepository>().deleteResult(
              Provider.of<UserRepository>(context, listen: false).user.uid,
              currentResultId);
          Navigator.pop(context);
        }
      },
    );
  }
}
