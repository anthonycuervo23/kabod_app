import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';
import 'package:kabod_app/service/api_service.dart';

class ResultDetailWidget extends StatelessWidget {
  ResultDetailWidget(
      {Key key, @required this.result, this.index, this.onDelete, this.onEdit})
      : super(key: key);

  final Result result;
  final int index;
  final Function(int) onDelete;
  final Function(int) onEdit;

  final ApiService api = ApiService();
  final Duration duration = Duration();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DividerMedium(),
            Text(
                result.createdAt != null
                    ? DateFormat('MMMM d, y').format(
                        DateTime.fromMillisecondsSinceEpoch(result.createdAt))
                    : 'No Date',
                style: TextStyle(
                    color: kWhiteTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            DividerSmall(),
            durationFromString(result.time) != duration
                ? Text(S.of(context).prTime(result.time),
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18))
                : Container(),
            result.reps != null
                ? Text(S.of(context).prReps(result.reps.toString()),
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18))
                : Container(),
            result.weight != null
                ? Text(S.of(context).prWeight(result.weight),
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18))
                : Container(),
            result.comment != ''
                ? Text(S.of(context).prComment(result.comment),
                    style: TextStyle(color: kWhiteTextColor, fontSize: 18))
                : Container(),
            ButtonTheme(
              child: ButtonBar(
                children: [
                  TextButton(
                    child: Text(S.of(context).editButton,
                        style: TextStyle(color: kWhiteTextColor)),
                    onPressed: () => onEdit(index),
                  ),
                  TextButton(
                    child: Text(S.of(context).deleteButton,
                        style: TextStyle(color: kWhiteTextColor)),
                    onPressed: () => onDelete(index),
                  )
                ],
              ),
            ),
          ]),
    );
  }
}
