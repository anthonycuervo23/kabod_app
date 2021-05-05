import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:provider/provider.dart';

//my imports
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/auth/components/login_fields.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/screens/commons/reusable_button.dart';

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
        // resizeToAvoidBottomPadding: true,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, right: 40.0),
                          child: Column(
                            children: [
                              Text(
                                S.of(context).resetPassword,
                                style: TextStyle(
                                    color: kWhiteTextColor, fontSize: 38),
                              ),
                              DividerSmall(),
                              Text(
                                S.of(context).resetPasswordInstructions,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        DividerBig(),
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: LoginField(
                            key: Key('email-field'),
                            controller: _emailField,
                            validator: (value) => (value.isEmpty)
                                ? S.of(context).validEmail
                                : null,
                            hintText: S.of(context).loginFormHintEmail,
                            labelText: 'E-mail',
                            isPassword: false,
                          ),
                        ),
                        DividerBig(),
                      ],
                    ),
                  ),
                ),
                DividerBig(),
                ReusableButton(
                  onPressed: () async {
                    await _resetPassword();
                  },
                  child:
                      Text(S.of(context).sendButton, style: kTextButtonStyle),
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
    bool resetPasswordResult = !await user.resetPassword(_emailField.text);
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
                  resetPasswordResult
                      ? Image.asset(
                          'assets/images/incorrect.png',
                          width: 65.0,
                        )
                      : Image.asset(
                          'assets/images/verificated.png',
                          width: 65.0,
                        ),
                  DividerSmall(),
                  resetPasswordResult
                      ? Text(
                          'ERROR',
                          style: TextStyle(
                              color: kWhiteTextColor,
                              fontSize: 38,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          S.of(context).success,
                          style: TextStyle(
                              color: kWhiteTextColor,
                              fontSize: 38,
                              fontWeight: FontWeight.bold),
                        ),
                  DividerSmall(),
                  resetPasswordResult
                      ? Text(
                          S.of(context).newPasswordError,
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 16),
                        )
                      : Text(
                          S.of(context).newPasswordAlert,
                        ),
                  DividerSmall(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kButtonColor),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (resetPasswordResult) {
                            Navigator.pop(context);
                          } else {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.loginRoute);
                          }
                        },
                        child: Text(
                          resetPasswordResult
                              ? S.of(context).tryAgain
                              : S.of(context).continuoToSignIn,
                          style: TextStyle(color: kWhiteTextColor),
                        )),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _emailField.dispose();
    super.dispose();
  }
}
