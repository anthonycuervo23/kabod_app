import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kabod_app/core/model/wod_type_options.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//my imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_button.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';
import 'package:kabod_app/screens/home/repository/wod_repository.dart';
import 'package:kabod_app/screens/wods/add_wod.dart';

class AddWodForm extends StatelessWidget {
  AddWodForm({
    Key key,
    @required GlobalKey<FormBuilderState> formKey,
    @required this.widget,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;
  final AddWodScreen widget;

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
              initialValue: widget.currentWod != null
                  ? widget.currentWod.date
                  : widget.selectedDay ?? DateTime.now(),
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
                  initialValue: widget.currentWod?.type,
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
                  initialValue: widget.currentWod?.title,
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
                  initialValue: widget.currentWod?.description,
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
              // onPressed: () {
              //   bool validated = _formKey.currentState.validate();
              //   if (validated) {
              //     _formKey.currentState.save();
              //     final data =
              //         Map<String, dynamic>.from(_formKey.currentState.value);
              //     context.read<WodRepository>().addWod(data);
              //     Navigator.pop(context);
              //   }
              // },
              onPressed: () async {
                bool validated = _formKey.currentState.validate();
                if (validated) {
                  _formKey.currentState.save();
                  try {
                    if (widget.currentWod != null) {
                      final data = Map<String, dynamic>.from(
                          _formKey.currentState.value);
                      context
                          .read<WodRepository>()
                          .updateWod(widget.currentWod.id, data);
                    } else {
                      final data = Map<String, dynamic>.from(
                          _formKey.currentState.value);
                      context.read<WodRepository>().addWod(data);
                    }
                    Navigator.pop(context);
                  } catch (e) {
                    print(e);
                  }
                }
              },
              text: widget.currentWod != null ? 'UPDATE' : 'SAVE')
        ],
      ),
    );
  }
}
