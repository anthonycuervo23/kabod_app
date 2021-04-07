import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//My Imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/navigationDrawer/model/drawer_notifier.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer(this.currentPage);

  final String currentPage;
  @override
  Widget build(BuildContext context) {
    final currentDrawer =
        Provider.of<DrawerStateInfo>(context).getCurrentDrawer;
    final userRepository = Provider.of<UserRepository>(context);
    return Container(
      width: 250,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            image: DecorationImage(
              image: AssetImage("assets/images/drawer_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.topCenter,
                      child: Image.asset(
                        'assets/images/logo_white.png',
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: currentDrawer == 0 ? kListTileSelected : null,
                      child: ListTile(
                        leading: Image.asset('assets/icons/home_icon.png'),
                        title: Text('Home', style: kListTileTextStyle),
                        onTap: () {
                          Navigator.of(context).pop();
                          if (this.currentPage == AppRoutes.homeRoute) return;

                          Provider.of<DrawerStateInfo>(context, listen: false)
                              .setCurrentDrawer(0);

                          Navigator.pushNamed(context, AppRoutes.homeRoute);
                        },
                      ),
                    ),
                    Container(
                      decoration: currentDrawer == 1 ? kListTileSelected : null,
                      child: ListTile(
                        leading:
                            Image.asset('assets/icons/whiteboard_icon.png'),
                        title: Text(
                          'LeaderBoard',
                          style: kListTileTextStyle,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          if (this.currentPage == AppRoutes.leaderBoardRoute)
                            return;

                          Provider.of<DrawerStateInfo>(context, listen: false)
                              .setCurrentDrawer(1);

                          Navigator.pushNamed(
                              context, AppRoutes.leaderBoardRoute);
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: currentDrawer == 2 ? kListTileSelected : null,
                      child: ListTile(
                          leading: Image.asset('assets/icons/logout_icon.png'),
                          title: Text(
                            'Logout',
                            style: kListTileTextStyle,
                          ),
                          onTap: () {
                            userRepository.signOut();
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}