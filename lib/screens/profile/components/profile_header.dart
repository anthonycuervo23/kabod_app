import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;
  final bool showButton;

  const ProfileHeader(
      {Key key,
      @required this.coverImage,
      @required this.avatar,
      this.title,
      this.showButton = false,
      this.subtitle,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 130),
          child: Column(
            children: [
              Avatar(
                image: avatar,
                radius: 70,
                backgroundColor: kButtonColor,
                borderColor: kPrimaryColor,
                borderWidth: 3.0,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;
  final Function onButtonPressed;
  final bool showButton;

  const Avatar(
      {Key key,
      @required this.image,
      this.borderColor,
      this.showButton = false,
      this.onButtonPressed,
      this.backgroundColor,
      this.radius,
      this.borderWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      CircleAvatar(
        radius: radius + borderWidth,
        backgroundColor: borderColor,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor != null
              ? backgroundColor
              : Theme.of(context).primaryColor,
          child: CircleAvatar(
            radius: radius - borderWidth,
            backgroundImage: image,
          ),
        ),
      ),
      if (showButton)
        Positioned(
          bottom: 0,
          right: -30,
          child: MaterialButton(
            elevation: 1,
            color: Colors.white,
            shape: CircleBorder(),
            child: Icon(Icons.camera_alt),
            padding: const EdgeInsets.all(4.0),
            onPressed: onButtonPressed,
          ),
        )
    ]);
  }
}
