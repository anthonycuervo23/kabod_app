import 'package:flutter/material.dart';
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

//My imports
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
    return Scaffold(
      appBar: AppBar(
        shape: kAppBarShape,
        title: Text(
          'Save your Results',
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
                Text('Back Squat',
                    style: TextStyle(fontSize: 24, color: kWhiteTextColor)),
                PrResultsForm(
                  formKey: _formKey,
                  initialTimer: initialTimer,
                  onTimerDurationChanged: (value) {
                    setState(() {
                      initialTimer = value;
                    });
                  },
                ),
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, color: kTextColor),
                        SizedBox(width: 8),
                        Text(DateTime.now().toString())
                      ],
                    )),
                  ],
                ),
                DividerSmall(),
              ],
            ),
          ),
          DividerBig(),
          ReusableButton(
            onPressed: () {
              // _processing ? null :
              bool validated = _formKey.currentState.validate();
              if (validated) {
                _formKey.currentState.save();
                setState(() {
                  _processing = true;
                });
                // Need to fix this part.!!
                final data =
                    Map<String, dynamic>.from(_formKey.currentState.value);
                data['time'] = stringFromDuration(initialTimer);
                // data['result_date'] = widget.currentWod.date.millisecondsSinceEpoch;
                data['reps'] =
                    data['reps'] != null ? int.parse(data['reps']) : null;
                //data['weight'] = data['weight'] ?? null;
                api.createResult(Result(weight: data['weight'] ?? null),
                    widget.selectedExercise.id);
                Navigator.pop(context);
              }
            },
            child: _processing
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kBackgroundColor),
                  )
                : Text('SAVE RESULT', style: kTextButtonStyle),
          ),
          DividerMedium(),
        ],
      ),
    );
  }
}
