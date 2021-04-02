import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/repository/user_repository.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
    this.height,
    this.shape,
    this.title,
    this.bottom,
    this.flexibleSpace,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final ShapeBorder shape;
  final Text title;
  final TabBar bottom;
  final FlexibleSpaceBar flexibleSpace;
  final double height;

  @override
  Widget build(BuildContext context) {
    final userRepository = Provider.of<UserRepository>(context);
    return AppBar(
      bottom: bottom,
      flexibleSpace: flexibleSpace,
      title: title,
      centerTitle: true,
      shape: shape,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset('assets/icons/drawer_icon.png'),
        onPressed: () {
          Navigator.pop(context);
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      actions: [
        InkWell(
          onTap: () => userRepository.signOut(),
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20, top: 10, left: 8, bottom: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: userRepository.userModel.photoUrl != null
                  ? CachedNetworkImage(
                      imageUrl: userRepository.userModel.photoUrl,
                      placeholder: (context, url) => CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kButtonColor)))
                  : Image.asset('assets/images/profile_image.jpg'),
            ),
          ),
        ),
      ],
    );
  }

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
