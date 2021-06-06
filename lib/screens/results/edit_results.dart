import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/results/components/delete_result_button.dart';
import 'package:kabod_app/screens/results/model/results_model.dart';

class EditResultScreen extends StatelessWidget {
  final Result currentResult;

  EditResultScreen({this.currentResult});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: kAppBarShape,
        title: Text(S.of(context).appBarResultDetails,
            style: TextStyle(
                color: kTextColor,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
            icon: Icon(Icons.check, color: kButtonColor),
            onPressed: () => Navigator.pop(context)),
        actions: [DeleteResultButton(currentResultId: currentResult.id)],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: kDefaultPadding, right: kDefaultPadding),
        child: ListView(
          children: [
            DividerBig(),
            Text(S.of(context).wodNameResult(currentResult.wodName),
                style: TextStyle(fontSize: 26)),
            Text(S.of(context).wodDateResult(
                DateFormat('EEEE, d MMMM').format(currentResult.date))),
            DividerBig(),
            currentResult.rx == true
                ? Text('RX',
                    style: TextStyle(
                      color: kButtonColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ))
                : Text(S.of(context).scale,
                    style: TextStyle(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
            DividerMedium(),
            Text(
              (currentResult.time == Duration() &&
                      currentResult.rounds == null &&
                      currentResult.customScore == null)
                  ? S.of(context).weightResult(currentResult.weight)
                  : (currentResult.time == Duration() &&
                          currentResult.customScore == null)
                      ? S.of(context).totalRepsRounds(
                          currentResult.rounds, currentResult.reps)
                      : (currentResult.time != Duration())
                          ? S.of(context).finalTime(currentResult.time)
                          : S
                              .of(context)
                              .scoreResult(currentResult.customScore),
              style: TextStyle(fontSize: 24),
            ),
            DividerMedium(),
            Text(
                currentResult.comment != null
                    ? currentResult.comment
                    : S.of(context).noComments,
                style: TextStyle(fontSize: 24)),
            DividerMedium(),
            currentResult.photoUrl != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                            width: 300,
                            fit: BoxFit.contain,
                            imageUrl: currentResult.photoUrl,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kButtonColor))),
                      ),
                    ),
                  )
                : Text(S.of(context).noPhoto, style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
