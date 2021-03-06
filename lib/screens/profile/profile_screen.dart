import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:provider/provider.dart';

//My imports
import 'package:kabod_app/navigationDrawer/model/drawer_notifier.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/screens/profile/components/profile_header.dart';
import 'package:kabod_app/screens/profile/components/user_info.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = Provider.of<UserRepository>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (userRepository.userModel != null) ...[
              ProfileHeader(
                avatar: userRepository.userModel.photoUrl != null
                    ? CachedNetworkImageProvider(
                        userRepository.userModel.photoUrl,
                      )
                    : AssetImage(
                        "assets/images/profile_image.jpg",
                      ),
                coverImage: AssetImage(
                  "assets/images/profile_background.jpg",
                ),
              ),
              if (userRepository.userModel.name != null) ...[
                Center(
                  child: Text(
                    userRepository.userModel.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: kWhiteTextColor),
                  ),
                ),
                Center(
                  child: userRepository.userModel.admin == false
                      ? Text(
                          S.of(context).athlete,
                          style: TextStyle(color: kButtonColor, fontSize: 18),
                        )
                      : Text(
                          'Coach',
                          style: TextStyle(color: kButtonColor, fontSize: 18),
                        ),
                )
              ],
              SizedBox(height: 10.0),
              UserInfo(),
            ],
            ...ListTile.divideTiles(
              color: Theme.of(context).dividerColor,
              tiles: [
                ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: kButtonColor,
                  ),
                  title: Text(
                    S.of(context).editProfile,
                    style: TextStyle(
                        fontSize: 20,
                        color: kTextColor,
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () => Navigator.pushNamed(
                      context, AppRoutes.editProfileRoute,
                      arguments: userRepository.userModel),
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: kButtonColor,
                  ),
                  title: Text(
                    S.of(context).drawerLogout,
                    style: TextStyle(
                        fontSize: 20,
                        color: kTextColor,
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () async {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.loginRoute, (Route route) => false);
                    Provider.of<DrawerStateInfo>(context, listen: false)
                        .setCurrentDrawer(0);
                    await userRepository.signOut();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
