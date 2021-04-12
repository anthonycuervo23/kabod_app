import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabod_app/core/model/wod_type_options.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

//My imports
import 'package:kabod_app/screens/wods/model/wod_model.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:kabod_app/screens/commons/dividers.dart';

class AddResultsForm extends StatefulWidget {
  AddResultsForm(
      {Key key,
      @required GlobalKey<FormBuilderState> formKey,
      this.currentWod,
      this.initialTimer,
      this.onTimerDurationChanged})
      : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;
  final Wod currentWod;
  final ValueChanged<Duration> onTimerDurationChanged;
  final Duration initialTimer;

  @override
  _AddResultsFormState createState() => _AddResultsFormState();
}

class _AddResultsFormState extends State<AddResultsForm> {
  bool rx = false;
  TextEditingController _controllerTimer;

  Duration _selectedTimer;

  @override
  void initState() {
    super.initState();
    _controllerTimer = TextEditingController();
    _selectedTimer = widget.initialTimer;
  }

  @override
  Widget build(BuildContext context) {
    final currentWodType = enumFromString(widget.currentWod.type);
    Duration nullTime = Duration(
        hours: 0, minutes: 0, seconds: 0, microseconds: 0, milliseconds: 0);
    return FormBuilder(
      key: widget._formKey,
      child: Column(
        children: [
          FormBuilderSwitch(
            activeColor: kButtonColor,
            name: 'rx',
            onChanged: (value) {
              setState(() {
                rx = value;
              });
            },
            title: Text(
              'RX',
              style: rx
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
          if (currentWodType == WodTypeOptions.time)
            TextFormField(
              controller: _controllerTimer,
              cursorColor: kButtonColor,
              readOnly: true,
              onTap: () {
                selectTime(context);
              },
              decoration: InputDecoration(
                hintText: stringFromDuration(widget.initialTimer) ==
                        stringFromDuration(nullTime)
                    ? 'Time'
                    : stringFromDuration(widget.initialTimer),
                hintStyle: TextStyle(color: kWhiteTextColor, fontSize: 20),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor)),
              ),
            ),
          DividerMedium(),
          if (currentWodType == WodTypeOptions.amrap) ...[
            FormBuilderTextField(
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.integer(context),
                FormBuilderValidators.required(context),
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
          if (currentWodType == WodTypeOptions.weight)
            FormBuilderTextField(
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.numeric(context),
                FormBuilderValidators.required(context),
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
          if (currentWodType == WodTypeOptions.custom)
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
            validator: FormBuilderValidators.maxLength(context, 110),
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
                        initialTimerDuration: _selectedTimer,
                        onTimerDurationChanged: widget.onTimerDurationChanged,
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
    if (picked != null && picked != widget.initialTimer) {
      _selectedTimer = picked;
      _controllerTimer.text = stringFromDuration(_selectedTimer);
    }
  }
}
