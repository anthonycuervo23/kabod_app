import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my imports
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_button.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/auth/components/login_fields.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/auth/model/user_model.dart';

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
    final user = Provider.of<UserModel>(context);
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
                      (value.isEmpty) ? 'Please enter an email' : null,
                  labelText: 'E-Mail',
                  hintText: 'Enter your email',
                  isPassword: false,
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
                      (value.isEmpty) ? 'Please enter your password' : null,
                  labelText: 'Password',
                  hintText: 'Enter your password',
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
                  'Forgot Password?',
                  style: TextStyle(color: kWhiteTextColor),
                ),
              ),
              DividerBig(),
              user.status == Status.Authenticating
                  ? Center(child: CircularProgressIndicator())
                  : ReusableButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (!await user.signIn(_email.text, _password.text))
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(user.error),
                            ));
                        }
                      },
                      text: 'SIGN IN'),
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
