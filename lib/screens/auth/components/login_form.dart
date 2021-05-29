import 'package:flutter/material.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:provider/provider.dart';

//my imports
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_button.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/auth/components/login_fields.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/repository/user_repository.dart';

class GetLoginForm extends StatefulWidget {
  @override
  _GetLoginFormState createState() => _GetLoginFormState();
}

class _GetLoginFormState extends State<GetLoginForm> {
  TextEditingController _email;

  TextEditingController _password;

  FocusNode _passwordField;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: '');
    _password = TextEditingController(text: '');
    _passwordField = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                child: LoginField(
                  key: Key('email-field'),
                  controller: _email,
                  validator: (value) =>
                      (value.isEmpty) ? S.of(context).loginFormEmail : null,
                  labelText: 'E-Mail',
                  hintText: S.of(context).loginFormHintEmail,
                  isPassword: false,
                  inputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_passwordField),
                ),
              ),
              DividerMedium(),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                child: LoginField(
                  focusNode: _passwordField,
                  key: Key('password-field'),
                  controller: _password,
                  validator: (value) =>
                      (value.isEmpty) ? S.of(context).loginFormPassword : null,
                  labelText: S.of(context).loginFormLabelPassword,
                  hintText: S.of(context).loginFormHintPassword,
                  isSecure: true,
                  onEditingComplete: () async {
                    if (_formKey.currentState.validate()) {
                      if (!await user.signIn(_email.text, _password.text))
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(user.error),
                        ));
                    }
                  },
                ),
              ),
              DividerSmall(),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.ResetPasswordRoute),
                child: Text(
                  S.of(context).loginForgotPassword,
                  style: TextStyle(color: kWhiteTextColor),
                ),
              ),
              DividerBig(),
              user.status == Status.Authenticating
                  ? Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kBackgroundColor)))
                  : ReusableButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (!await user.signIn(_email.text, _password.text))
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(user.error),
                            ));
                        }
                      },
                      child: Text(S.of(context).loginSignIn,
                          style: kTextButtonStyle),
                    ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
