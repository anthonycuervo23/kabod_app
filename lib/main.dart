import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/auth/model/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: kButtonColor,
          ),
          scaffoldBackgroundColor: kBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          fontFamily: 'Nunito',
        ),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.loginRoute,
      ),
      providers: [
        ChangeNotifierProvider(create: (_) => UserModel.instance()),
      ],
    );
  }
}
