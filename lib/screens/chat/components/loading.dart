import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';

class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kButtonColor),
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}
