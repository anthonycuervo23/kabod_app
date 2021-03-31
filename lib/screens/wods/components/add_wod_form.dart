import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//my imports
import 'package:kabod_app/core/model/main_screen_model.dart';
import 'package:kabod_app/screens/wods/model/wod_model.dart';
import 'package:kabod_app/core/model/wod_type_options.dart';
import 'package:kabod_app/screens/wods/components/alert_dialog.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_button.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';
import 'package:kabod_app/screens/wods/repository/wod_repository.dart';

class AddWodForm extends StatelessWidget {
  AddWodForm({
    Key key,
    @required GlobalKey<FormBuilderState> formKey,
    @required this.currentWod,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;
  final Wod currentWod;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          DefaultCard(
            child: FormBuilderDateTimePicker(
              validator: FormBuilderValidators.required(context),
              name: 'wod_date',
              initialValue: currentWod != null
                  ? currentWod.date
                  : Provider.of<MainScreenModel>(context).selectedDate ??
                      DateTime.now(),
              inputType: InputType.date,
              format: DateFormat('EEEE, dd MMMM, yyyy'),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Image.asset('assets/icons/calendar_icon.png')),
            ),
          ),
          DividerBig(),
          Column(
            children: [
              DefaultCard(
                child: FormBuilderDropdown(
                  initialValue: currentWod?.type,
                  dropdownColor: kBackgroundColor,
                  validator: FormBuilderValidators.required(context),
                  name: 'wod_type',
                  decoration: InputDecoration(
                    labelText: 'WOD Type',
                    labelStyle: TextStyle(color: kTextColor),
                    border: InputBorder.none,
                  ),
                  items: WodTypeOptions.values
                      .map(
                        (type) => DropdownMenuItem(
                          value: wodTypeOptionsToString(type),
                          child: Text(wodTypeOptionsToString(type)),
                        ),
                      )
                      .toList(),
                ),
              ),
              DividerMedium(),
              DefaultCard(
                child: FormBuilderTextField(
                  initialValue: currentWod?.title,
                  validator: FormBuilderValidators.required(context),
                  name: 'wod_name',
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'WOD Name',
                    hintStyle: TextStyle(color: kTextColor),
                  ),
                ),
              ),
              DividerMedium(),
              DefaultCard(
                child: FormBuilderTextField(
                  initialValue: currentWod?.description,
                  validator: FormBuilderValidators.required(context),
                  name: 'wod_description',
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: 'WOD Description...',
                      hintStyle: TextStyle(color: kTextColor),
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
          DividerMedium(),
          ReusableButton(
              onPressed: () async {
                bool validated = _formKey.currentState.validate();
                if (validated) {
                  _formKey.currentState.save();
                  if (currentWod != null) {
                    final data =
                        Map<String, dynamic>.from(_formKey.currentState.value);
                    data['wod_date'] =
                        (data['wod_date'] as DateTime).millisecondsSinceEpoch;
                    bool isSuccessful = await context
                        .read<WodRepository>()
                        .updateWod(currentWod.id, data);
                    if (isSuccessful) {
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialogWod(
                          content:
                              'you cannot update a WOD from a day that has already passed',
                        ),
                      );
                    }
                  } else {
                    final data =
                        Map<String, dynamic>.from(_formKey.currentState.value);
                    data['wod_date'] =
                        (data['wod_date'] as DateTime).millisecondsSinceEpoch;
                    bool isSuccessful =
                        await context.read<WodRepository>().addWod(data);
                    if (isSuccessful) {
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialogWod(
                          content:
                              'you cannot create a WOD from a day that has already passed',
                        ),
                      );
                    }
                  }
                }
              },
              child: Text(
                currentWod != null ? 'UPDATE' : 'SAVE',
                style: kTextButtonStyle,
              ))
        ],
      ),
    );
  }
}
