import 'package:flutter/material.dart';
import 'package:kabod_app/core/presentation/routes.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
    this.shape,
    this.title,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final ShapeBorder shape;
  final Text title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      shape: shape,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset('assets/icons/drawer_icon.png'),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.classesRoute);
          },
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20, top: 15, left: 8, bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.asset('assets/images/profile_image.jpg'),
            ),
          ),
        ),
      ],
    );
  }

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
