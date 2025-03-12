import 'package:flutter/material.dart';
import 'package:fyp_project/routings/routeName/routes_name.dart';
import 'package:fyp_project/routings/routeScreen/route_screen.dart';
import 'package:fyp_project/view/auth/registerScreen/register_screen.dart';
import 'package:fyp_project/view/splashScreen/splash_screen.dart';

import 'package:fyp_project/view_modal/provider/multiAppProviders/multi_appProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: multiAppProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteName.splashscreen,
        routes: RouteScreen.getScreens(),
        home: RegisterScreen(),
      ),
    );
  }
}
