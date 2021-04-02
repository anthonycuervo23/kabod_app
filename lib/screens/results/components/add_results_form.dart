import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

//My imports
import 'package:kabod_app/screens/wods/model/wod_model.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/results/model/results_form_notifier.dart';

class AddResultsForm extends StatelessWidget {
  const AddResultsForm(
      {Key key, @required GlobalKey<FormBuilderState> formKey, this.currentWod})
      : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;
  final Wod currentWod;

  @override
  Widget build(BuildContext context) {
    Duration nullTime = Duration(
        hours: 0, minutes: 0, seconds: 0, microseconds: 0, milliseconds: 0);
    ResultFormNotifier resultFormNotifier =
        Provider.of<ResultFormNotifier>(context, listen: false);
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderSwitch(
            activeColor: kButtonColor,
            name: 'rx',
            onChanged: (value) {
              resultFormNotifier.changeRxValue(value);
            },
            title: Text(
              'RX',
              style: resultFormNotifier.rx
                  ? TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kButtonColor,
                      fontStyle: FontStyle.italic)
                  : TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            initialValue: false,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kButtonColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kButtonColor)),
            ),
          ),
          DividerMedium(),
          if (currentWod.type == 'For Time')
            TextFormField(
              cursorColor: kButtonColor,
              readOnly: true,
              onTap: () {
                selectTime(context);
                print(stringFromDuration(resultFormNotifier.initialTimer));
              },
              decoration: InputDecoration(
                hintText: stringFromDuration(resultFormNotifier.initialTimer) ==
                        stringFromDuration(nullTime)
                    ? 'Time'
                    : stringFromDuration(resultFormNotifier.initialTimer),
                hintStyle: TextStyle(color: kWhiteTextColor, fontSize: 20),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor)),
              ),
            ),
          DividerMedium(),
          if (currentWod.type == 'AMRAP') ...[
            FormBuilderTextField(
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.integer(context),
                FormBuilderValidators.maxLength(context, 2)
              ]),
              name: 'rounds',
              style: TextStyle(color: kWhiteTextColor, fontSize: 20),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor)),
                labelText: 'Rounds',
                labelStyle: TextStyle(color: kWhiteTextColor, fontSize: 20),
              ),
            ),
            DividerMedium(),
            FormBuilderTextField(
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.integer(context),
                FormBuilderValidators.maxLength(context, 3)
              ]),
              name: 'reps',
              style: TextStyle(color: kWhiteTextColor, fontSize: 20),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor)),
                labelText: 'Reps',
                labelStyle: TextStyle(color: kWhiteTextColor, fontSize: 20),
              ),
            ),
            DividerMedium(),
          ],
          if (currentWod.type == 'For Weight')
            FormBuilderTextField(
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.numeric(context),
                FormBuilderValidators.maxLength(context, 6)
              ]),
              name: 'weight',
              style: TextStyle(color: kWhiteTextColor, fontSize: 20),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor)),
                labelText: 'Weight',
                labelStyle: TextStyle(color: kWhiteTextColor, fontSize: 20),
              ),
            ),
          DividerMedium(),
          if (currentWod.type == 'Custom')
            FormBuilderTextField(
              name: 'custom_score',
              style: TextStyle(color: kWhiteTextColor, fontSize: 20),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor)),
                labelText: 'Score',
                labelStyle: TextStyle(color: kWhiteTextColor, fontSize: 20),
              ),
            ),
          DividerMedium(),
          FormBuilderTextField(
            name: 'result_comment',
            style: TextStyle(color: kWhiteTextColor, fontSize: 20),
            maxLines: 8,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: 'Optional comments...',
                hintStyle: TextStyle(color: kWhiteTextColor, fontSize: 20),
                border: InputBorder.none),
          ),
        ],
      ),
    );
  }

  Future<Null> selectTime(BuildContext context) async {
    ResultFormNotifier resultFormNotifier =
        Provider.of<ResultFormNotifier>(context, listen: false);
    final picked = await showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: DefaultTextStyle.merge(
                      style: TextStyle(color: kTextColor),
                      child: CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hms,
                        minuteInterval: 1,
                        secondInterval: 1,
                        initialTimerDuration: resultFormNotifier.initialTimer,
                        onTimerDurationChanged: (Duration changedTimer) {
                          resultFormNotifier
                              .changeInitialTimerValue(changedTimer);
                        },
                      ),
                    ),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ));
    if (picked != null && picked != resultFormNotifier.initialTimer) {
      resultFormNotifier.changeInitialTimerValue(picked);
    }
  }
}
