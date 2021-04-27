import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';
import 'package:kabod_app/service/api_service.dart';

class ResultDetailWidget extends StatefulWidget {
  const ResultDetailWidget({Key key, @required this.results, this.index})
      : super(key: key);

  final List<Result> results;
  final int index;

  @override
  _ResultDetailWidgetState createState() => _ResultDetailWidgetState();
}

class _ResultDetailWidgetState extends State<ResultDetailWidget> {
  _ResultDetailWidgetState();

  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: kPrimaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all((Radius.circular(15)))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          leading: Icon(
            Icons.album,
            size: 70,
            color: kButtonColor,
          ),
          title: Text('Abr 20, 2021',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text('Time: 00:01:00',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        ButtonTheme(
          child: ButtonBar(
            children: [
              TextButton(
                child:
                    const Text('Edit', style: TextStyle(color: Colors.white)),
                onPressed: () {},
              ),
              TextButton(
                child:
                    const Text('Delete', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _confirmDeleteDialog();
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> _confirmDeleteDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kBackgroundColor,
          title: Text(
            'Warning!',
            style: TextStyle(
                color: kButtonColor, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(color: kTextColor, fontSize: 18),
              ),
              onPressed: () {
                api.deleteResult(widget.results[widget.index].id);
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              },
            ),
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: kTextColor, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
