import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/personal_records/components/result_details.dart';
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';

class ResultsList extends StatelessWidget {
  final List<Result> results;
  ResultsList({Key key, this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: results == null ? 0 : results.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              elevation: 0,
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all((Radius.circular(10)))),
              child: ResultDetailWidget(results: results, index: index));
        });
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({Key key, @required this.results, this.index})
      : super(key: key);

  final List<Result> results;
  final int index;

  @override
  _NewWidgetState createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.star, color: kButtonColor, size: 40),
      title: Text(
        widget.results[widget.index].scoreType,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
