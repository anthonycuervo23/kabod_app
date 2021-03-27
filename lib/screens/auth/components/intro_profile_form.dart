import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
          TextFieldInput(
            name: 'name',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
            icon: Icons.person,
            hint: 'Name',
            inputType: TextInputType.name,
            inputAction: TextInputAction.next,
          ),
          TextDatePickerFieldInput(
            validator: FormBuilderValidators.required(context),
            name: 'birth_date',
            icon: Icons.date_range,
            hint: 'Birth date',
            inputAction: TextInputAction.done,
          ),
          TextFieldInput(
            name: 'phone',
            icon: Icons.phone,
            hint: 'Phone Number',
            inputType: TextInputType.phone,
            inputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.integer(context),
              FormBuilderValidators.minLength(context, 7),
              FormBuilderValidators.maxLength(context, 11),
            ]),
          ),
          TextFieldInput(
            name: 'address',
            icon: Icons.home,
            hint: 'Address',
            inputType: TextInputType.streetAddress,
            inputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}
