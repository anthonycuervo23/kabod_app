import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/results/components/delete_result_button.dart';
import 'package:kabod_app/screens/results/model/results_model.dart';
import 'package:kabod_app/screens/wods/model/wod_model.dart';

class EditResultScreen extends StatelessWidget {
  final Result currentResult;
  final Wod currentWod;
  EditResultScreen({this.currentResult, this.currentWod});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: kAppBarShape,
        title: Text('Result Details',
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
            Text('Wod name: ${currentWod.title}',
                style: TextStyle(fontSize: 26)),
            Text('Date: ${DateFormat('EEEE, d MMMM').format(currentWod.date)}'),
            DividerBig(),
            currentResult.rx == true
                ? Text('RX',
                    style: TextStyle(
                      color: kButtonColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ))
                : Text('Scale',
                    style: TextStyle(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
            DividerMedium(),
            Text(
              (currentResult.time == Duration() &&
                      currentResult.rounds == null &&
                      currentResult.customScore == null)
                  ? 'Weight: ${currentResult.weight} lb'
                  : (currentResult.time == Duration() &&
                          currentResult.customScore == null)
                      ? 'Total Rounds and Reps: ${currentResult.rounds} rounds and ${currentResult.reps} reps'
                      : (currentResult.time != Duration())
                          ? 'Final Time: ${currentResult.time}'
                          : 'Score: ${currentResult.customScore}',
              style: TextStyle(fontSize: 24),
            ),
            DividerMedium(),
            Text(
                currentResult.comment != null
                    ? currentResult.comment
                    : 'No comments',
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
                : Text('No Photo to show', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}