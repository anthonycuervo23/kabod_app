import 'package:flutter/material.dart';

//my imports
import 'package:kabod_app/core/presentation/constants.dart';

class DefaultCard extends StatelessWidget {
  final Widget child;

  DefaultCard({this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
      child: Card(
        elevation: 0,
        color: kPrimaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all((Radius.circular(10)))),
        child: Padding(
          padding: const EdgeInsets.only(
              left: kDefaultPadding, right: kDefaultPadding),
          child: child,
        ),
      ),
    );
  }
}
