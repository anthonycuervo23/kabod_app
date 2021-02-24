import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my imports
import 'package:kabod_app/screens/auth/model/user_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('Home page')),
        RaisedButton(
            onPressed: () {
              user.signOut();
              print(user.status);
            },
            child: Text('Log Out'))
      ],
    ));
  }
}
