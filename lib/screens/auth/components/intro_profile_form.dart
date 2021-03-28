import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//My imports
import 'package:kabod_app/screens/auth/components/text_fields_input.dart';

class IntroProfileForm extends StatelessWidget {
  const IntroProfileForm({
    Key key,
    @required GlobalKey<FormBuilderState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          GenderPickerFieldInput(
            name: 'gender',
            hint: 'Select Gender',
            icon: FontAwesomeIcons.venusMars,
            validator: FormBuilderValidators.required(context),
          ),
          TextFieldInput(
            name: 'name',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
            icon: FontAwesomeIcons.user,
            hint: 'Name',
            inputType: TextInputType.name,
            inputAction: TextInputAction.next,
          ),
          TextDatePickerFieldInput(
            validator: FormBuilderValidators.required(context),
            name: 'birth_date',
            icon: FontAwesomeIcons.calendarAlt,
            hint: 'Birth date',
            inputAction: TextInputAction.done,
          ),
          TextFieldInput(
            name: 'phone',
            icon: FontAwesomeIcons.phoneAlt,
            hint: 'Phone Number',
            inputType: TextInputType.phone,
            inputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.integer(context),
              FormBuilderValidators.minLength(context, 7),
              FormBuilderValidators.maxLength(context, 11),
            ]),
          ),
        ],
      ),
    );
  }
}
