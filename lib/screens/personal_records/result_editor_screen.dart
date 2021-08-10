import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

//My imporjust wanna build a instagram story feature ts
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:kabod_app/screens/personal_records/components/pr_result_form.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_button.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';
import 'package:kabod_app/service/api_service.dart';

class EditResultDetailsScreen extends StatefulWidget {
  final Result currentResult;
  final Exercise selectedExercise;
  EditResultDetailsScreen({this.currentResult, this.selectedExercise});

  @override
  _EditResultDetailsScreenState createState() =>
      _EditResultDetailsScreenState();
}

class _EditResultDetailsScreenState extends State<EditResultDetailsScreen> {
  bool _processing;

  Duration initialTimer = Duration();

  final _formKey = GlobalKey<FormBuilderState>();

  final ApiService api = ApiService();

  @override
  void initState() {
    _processing = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.currentResult.id);
    return Scaffold(
      appBar: AppBar(
        shape: kAppBarShape,
        title: Text(
          widget.currentResult != null
              ? S.of(context).saveResult
              : S.of(context).editResult,
          style: TextStyle(
              color: kTextColor, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: kButtonColor),
            onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: kDefaultPadding),
        children: [
          DefaultCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DividerMedium(),
                Text(widget.selectedExercise.exercise,
                    style: TextStyle(fontSize: 24, color: kWhiteTextColor)),
                PrResultsForm(
                  formKey: _formKey,
                  initialTimer: initialTimer,
                  currentResult: widget.currentResult,
                  onTimerDurationChanged: (value) {
                    setState(() {
                      initialTimer = value;
                    });
                  },
                ),
              ],
            ),
          ),
          DividerBig(),
          ReusableButton(
            onPressed: _processing
                ? null
                : widget.currentResult != null
                    ? _updateResult
                    : _saveResult,
            child: _processing
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kBackgroundColor),
                  )
                : Text(
                    widget.currentResult != null
                        ? S.of(context).updateResultButton
                        : S.of(context).saveResultButton,
                    style: kTextButtonStyle),
          ),
          DividerMedium(),
        ],
      ),
    );
  }

  _saveResult() async {
    bool validated = _formKey.currentState.validate();
    if (validated) {
      _formKey.currentState.save();
      setState(() {
        _processing = true;
      });
      final data = Map<String, dynamic>.from(_formKey.currentState.value);
      var result = await api.createResult(
          Result(
            weight: data['weight'] != '' ? int.parse(data['weight']) : 0,
            reps: data['reps'] != '' ? int.parse(data['reps']) : 0,
            time: stringFromDuration(initialTimer),
            comment: data['result_comment'] ?? null,
            createdAt: data['createdAt'].millisecondsSinceEpoch,
          ),
          widget.selectedExercise.id);
      Navigator.pop(context, result);
    }
  }

  _updateResult() async {
    bool validated = _formKey.currentState.validate();
    if (validated) {
      _formKey.currentState.save();
      setState(() {
        _processing = true;
      });
      final data = Map<String, dynamic>.from(_formKey.currentState.value);
      await api.updateResult(
          widget.currentResult.id,
          Result(
              weight: data['weight'] != '' ? int.parse(data['weight']) : 0,
              reps: data['reps'] != '' ? int.parse(data['reps']) : 0,
              time: stringFromDuration(initialTimer),
              comment: data['result_comment'] ?? null,
              createdAt: data['createdAt'].millisecondsSinceEpoch));
      int count = 0;
      Navigator.of(context).popUntil((_) => count++ >= 2);
    }
  }
}
