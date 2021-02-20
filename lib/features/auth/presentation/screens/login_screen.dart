import 'package:flutter/material.dart';
import 'file:///C:/Users/antho/Desktop/kabod_project/kabod_app/lib/core/presentation/res/constants.dart';
import 'file:///C:/Users/antho/Desktop/kabod_project/kabod_app/lib/features/auth/presentation/components/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/login_background.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.transparent,
                Colors.transparent,
                kBackgroundColor.withOpacity(0.9),
                kBackgroundColor,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'images/logo_white.png',
              width: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          Center(
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
          ),
        ],
      ),
    );
  }
}
