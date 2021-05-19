import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//my imports
import 'package:kabod_app/core/repository/wod_repository.dart';
import 'package:kabod_app/core/model/main_screen_model.dart';
import 'package:kabod_app/screens/wods/model/wod_model.dart';
import 'package:kabod_app/core/model/wod_type_options.dart';
import 'package:kabod_app/screens/wods/components/alert_dialog.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_button.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';

class AddWodForm extends StatefulWidget {
  AddWodForm({
    Key key,
    @required GlobalKey<FormBuilderState> formKey,
    @required this.currentWod,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;
  final Wod currentWod;

  @override
  _AddWodFormState createState() => _AddWodFormState();
}

class _AddWodFormState extends State<AddWodForm> {
  DateTime _dropDownDate;
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget._formKey,
      child: Column(
        children: [
          DefaultCard(
            child: DateTimeField(
              decoration: (InputDecoration(
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white70,
                    size: 35,
                  ),
                  hintStyle: TextStyle(
                      color: kTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  hintText: S.of(context).selectDay)),
              style: TextStyle(
                fontSize: 18,
                color: kWhiteTextColor,
              ),
              format: DateFormat("EEEE d MMMM, y"),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(2021, 3, 21),
                    initialDate: widget.currentWod != null
                        ? widget.currentWod.date
                        : Provider.of<MainScreenModel>(context, listen: false)
                                .selectedDate ??
                            DateTime.now(),
                    lastDate: DateTime(2030, 12, 24));
              },
              onChanged: (newValue) {
                setState(() {
                  _dropDownDate = newValue;
                });
              },
            ),
          ),
          DividerBig(),
          Column(
            children: [
              DefaultCard(
                child: FormBuilderDropdown(
                  initialValue: widget.currentWod?.type,
                  dropdownColor: kBackgroundColor,
                  validator: FormBuilderValidators.required(context),
                  name: 'wod_type',
                  decoration: InputDecoration(
                    labelText: S.of(context).wodType,
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
                  initialValue: widget.currentWod?.title,
                  validator: FormBuilderValidators.required(context),
                  name: 'wod_name',
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: S.of(context).wodName,
                    hintStyle: TextStyle(color: kTextColor),
                  ),
                ),
              ),
              DividerMedium(),
              DefaultCard(
                child: FormBuilderTextField(
                  initialValue: widget.currentWod?.description,
                  validator: FormBuilderValidators.required(context),
                  name: 'wod_description',
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: S.of(context).wodDescription,
                      hintStyle: TextStyle(color: kTextColor),
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
          DividerMedium(),
          ReusableButton(
              onPressed: () async {
                bool validated = widget._formKey.currentState.validate();
                if (validated) {
                  widget._formKey.currentState.save();
                  if (widget.currentWod != null) {
                    final data = Map<String, dynamic>.from(
                        widget._formKey.currentState.value);
                    data['wod_date'] = _dropDownDate.millisecondsSinceEpoch;
                    bool isSuccessful = await context
                        .read<WodRepository>()
                        .updateWod(widget.currentWod.id, data);
                    if (isSuccessful) {
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialogWod(
                          content: S.of(context).cantUpdateWod,
                        ),
                      );
                    }
                  } else {
                    final data = Map<String, dynamic>.from(
                        widget._formKey.currentState.value);
                    data['wod_date'] = _dropDownDate.millisecondsSinceEpoch;
                    bool isSuccessful =
                        await context.read<WodRepository>().addWod(data);
                    if (isSuccessful) {
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialogWod(
                          content: S.of(context).cantCreateWod,
                        ),
                      );
                    }
                  }
                }
              },
              child: Text(
                widget.currentWod != null
                    ? S.of(context).updateButton
                    : S.of(context).saveButton,
                style: kTextButtonStyle,
              ))
        ],
      ),
    );
  }
}
