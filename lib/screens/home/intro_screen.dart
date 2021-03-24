import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//My imports
import 'package:kabod_app/screens/auth/model/user_repository.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: () {
                  _finishIntroScreen(context, user.user.uid);
                },
                child: Text('COMPLETE YOUR PROFILE'))));
  }
}

_finishIntroScreen(BuildContext context, user) async {
  await FirebaseFirestore.instance.collection('users').doc(user).update({
    'intro_seen': true,
  });
}
