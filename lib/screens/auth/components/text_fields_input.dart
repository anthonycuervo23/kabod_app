import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/model/gender_options.dart';

class TextFieldInput extends StatelessWidget {
  TextFieldInput({
    Key key,
    this.name,
    this.initialValue,
    this.validator,
    this.inputType,
    this.inputAction,
    this.icon,
    this.hint,
  }) : super(key: key);

  final String name;
  final String initialValue;
  final Function validator;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
            child: FormBuilderTextField(
          name: name,
          initialValue: initialValue,
          validator: validator,
          keyboardType: inputType,
          textInputAction: inputAction,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                icon,
                size: 28,
                color: kWhiteTextColor,
              ),
            ),
            hintText: hint,
            hintStyle:
                TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
          ),
          style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
        )),
      ),
    );
  }
}

class TextDatePickerFieldInput extends StatelessWidget {
  TextDatePickerFieldInput({
    Key key,
    this.name,
    this.initialValue,
    this.validator,
    this.inputType,
    this.inputAction,
    this.icon,
    this.hint,
  }) : super(key: key);

  final String name;
  final String initialValue;
  final Function validator;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
            child: FormBuilderDateTimePicker(
          format: DateFormat('dd MMMM, yyyy'),
          inputType: InputType.date,
          name: name,
          validator: validator,
          keyboardType: inputType,
          textInputAction: inputAction,
          initialDatePickerMode: DatePickerMode.year,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                icon,
                size: 28,
                color: kWhiteTextColor,
              ),
            ),
            hintText: hint,
            hintStyle:
                TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
          ),
          style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
        )),
      ),
    );
  }
}

class GenderPickerFieldInput extends StatelessWidget {
  GenderPickerFieldInput({
    Key key,
    this.name,
    this.initialValue,
    this.validator,
    this.inputType,
    this.inputAction,
    this.icon,
    this.hint,
  }) : super(key: key);

  final String name;
  final String initialValue;
  final Function validator;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: FormBuilderDropdown(
            dropdownColor: kBackgroundColor,
            validator: validator,
            name: name,
            style: TextStyle(fontSize: 20, color: Colors.white, height: 1.5),
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,
                  size: 28, color: kWhiteTextColor),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  icon,
                  size: 28,
                  color: kWhiteTextColor,
                ),
              ),
              hintText: hint,
              hintStyle:
                  TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
            ),
            items: GenderOptions.values
                .map(
                  (type) => DropdownMenuItem(
                    value: genderOptionsToString(type),
                    child: Text(genderOptionsToString(type)),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
