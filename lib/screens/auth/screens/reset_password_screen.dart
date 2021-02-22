import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/auth/components/login_fields.dart';
import 'package:kabod_app/screens/auth/data/user_repository.dart';
import 'package:kabod_app/screens/components/reusable_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _emailField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailField = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
        ),
        body: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Image.asset('assets/images/forgotten_login.png'),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, right: 40.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Reset Password\n\n',
                                  style: TextStyle(
                                      color: kWhiteTextColor, fontSize: 38),
                                ),
                                TextSpan(
                                  text:
                                      'Please enter your email address. You will receive a link to create a new password via email',
                                  style: TextStyle(
                                      // color: Colors.grey.shade500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 18.0),
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: LoginField(
                            key: Key('email-field'),
                            controller: _emailField,
                            validator: (value) => (value.isEmpty)
                                ? 'Please enter a valid email'
                                : null,
                            hintText: 'enter your email',
                            labelText: 'E-mail',
                            isPassword: false,
                          ),
                        ),
                        SizedBox(height: 18.0),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ReusableButton(
                  onPressed: () async {
                    await _resetPassword();
                  },
                  text: 'SEND',
                ),
              ],
            ),
          ),
        ));
  }

  _resetPassword() async {
    final user = Provider.of<UserRepository>(context, listen: false);
    print(_emailField.text);
    if (_formKey.currentState.validate()) {
      await user
          .resetPassword(_emailField.text)
          .then((value) => _showResetPasswordDialog(context));
    }
  }

  _showResetPasswordDialog(BuildContext context) async {
    final user = Provider.of<UserRepository>(context, listen: false);
    if (!await user.resetPassword(_emailField.text)) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: kBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              content: Container(
                height: 250.0,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/incorrect.png',
                      width: 65.0,
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'ERROR',
                      style: TextStyle(
                          color: kWhiteTextColor,
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'Please enter a valid email',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 16),
                    ),
                    SizedBox(height: 12.0),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: kButtonColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Try again',
                          style: TextStyle(color: kWhiteTextColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: kBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              content: Container(
                height: 260.0,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/verificated.png',
                      width: 65.0,
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'Success!',
                      style: TextStyle(
                          color: kWhiteTextColor,
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'We have sent a new reset link to your email',
                    ),
                    SizedBox(height: 12.0),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: kButtonColor,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.loginRoute);
                        },
                        child: Text(
                          'Continue to sign in',
                          style: TextStyle(color: kWhiteTextColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }
  }

  @override
  void dispose() {
    _emailField.dispose();
    super.dispose();
  }
}
