import 'package:flutter/material.dart';
import 'package:kabod_app/screens/auth/components/login_form.dart';
import 'package:kabod_app/core/presentation/constants.dart';

class GetLoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(left: 40, right: 40),
            child: LoginField(
              labelText: 'E-Mail',
              hintText: 'Enter your email',
              isPassword: false,
              textInputAction: TextInputAction.next,
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.only(left: 40, right: 40),
            child: LoginField(
              labelText: 'Password',
              hintText: 'Enter your password',
              isSecure: true,
            ),
          ),
          SizedBox(height: 12),
          InkWell(
            onTap: () {},
            child: Text(
              'Forgot Password?',
              style: TextStyle(color: kWhiteTextColor),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.only(left: 40, right: 40),
            child: RaisedButton(
              onPressed: () {},
              color: kButtonColor,
              child: Text(
                'SIGN IN',
                style: TextStyle(color: kWhiteTextColor, fontSize: 20),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
