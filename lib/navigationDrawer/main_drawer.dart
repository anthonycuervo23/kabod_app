import 'package:flutter/material.dart';
import 'package:kabod_app/generated/l10n.dart';
import 'package:provider/provider.dart';

//My Imports
import 'package:kabod_app/screens/timers/models/settings_model.dart';
import 'package:kabod_app/service/sharedPreferences.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/navigationDrawer/model/drawer_notifier.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer(this.currentPage);

  final String currentPage;

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final currentPage = this.widget.currentPage;
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
                    DrawerTile(
                        currentPage: currentPage,
                        position: 0,
                        copy: S.of(context).drawerHome,
                        imagePath: 'assets/icons/home_icon.png',
                        route: AppRoutes.homeRoute),
                    DrawerTile(
                        currentPage: currentPage,
                        position: 1,
                        copy: S.of(context).drawerLeaderBoard,
                        imagePath: 'assets/icons/whiteboard_icon.png',
                        route: AppRoutes.leaderBoardRoute),
                    DrawerTile(
                        currentPage: currentPage,
                        position: 2,
                        copy: S.of(context).drawerCalculator,
                        imagePath: 'assets/icons/calculator_icon.png',
                        route: AppRoutes.calculatorRoute),
                    DrawerTile(
                      currentPage: currentPage,
                      position: 3,
                      copy: S.of(context).drawerTimers,
                      imagePath: 'assets/icons/timer_icon.png',
                      route: AppRoutes.timersRoute,
                      arguments: [
                        Settings(SharedPrefs.sharedPrefs),
                        SharedPrefs.sharedPrefs,
                      ],
                    ),
                    DrawerTile(
                        currentPage: currentPage,
                        position: 4,
                        copy: S.of(context).drawerPersonalRecords,
                        imagePath: 'assets/icons/performance_icon.png',
                        route: AppRoutes.personalRecordsRoute),
                    DrawerTile(
                      currentPage: currentPage,
                      copy: S.of(context).drawerChat,
                      position: 5,
                      imagePath: 'assets/icons/chat_icon.png',
                      route: AppRoutes.chatRoute,
                      arguments: userRepository.user.uid,
                    ),
                  ],
                ),
                Column(
                  children: [
                    DrawerTile(
                        decoration: BoxDecoration(
                            color: Color(0xFF121212).withOpacity(0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        currentPage: currentPage,
                        position: 0,
                        copy: S.of(context).drawerLogout,
                        imagePath: 'assets/icons/logout_icon.png',
                        onTap: () async {
                          Navigator.pushNamedAndRemoveUntil(context,
                              AppRoutes.loginRoute, (Route route) => false);
                          Provider.of<DrawerStateInfo>(context, listen: false)
                              .setCurrentDrawer(0);
                          await userRepository.signOut();
                        })
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

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {Key key,
      @required this.currentPage,
      @required this.position,
      @required this.imagePath,
      this.route,
      this.arguments,
      @required this.copy,
      this.decoration,
      this.onTap})
      : super(key: key);
  final currentPage;
  final int position;
  final String imagePath;
  final String route;
  final Object arguments;
  final String copy;
  final Decoration decoration;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final currentDrawer =
        Provider.of<DrawerStateInfo>(context).getCurrentDrawer;
    Decoration localDecoration =
        currentDrawer == position ? kListTileSelected : null;
    if (decoration != null) {
      localDecoration = decoration;
    }
    return Container(
      decoration: localDecoration,
      child: ListTile(
        leading: Image.asset(imagePath),
        title: Text(copy, style: kListTileTextStyle),
        onTap: onTap ??
            () {
              Navigator.popUntil(context, (route) => route.isFirst);
              if (this.currentPage == route) return;

              Provider.of<DrawerStateInfo>(context, listen: false)
                  .setCurrentDrawer(position);

              Navigator.pushReplacementNamed(context, route,
                  arguments: arguments);
            },
      ),
    );
  }
}
