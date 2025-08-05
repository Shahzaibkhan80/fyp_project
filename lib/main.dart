import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fyp_project/firebase_options.dart';
import 'package:fyp_project/routings/routeName/routes_name.dart';
import 'package:fyp_project/routings/routeScreen/route_screen.dart';
import 'package:fyp_project/view_modal/provider/multiAppProviders/multi_appProvider.dart';
import 'package:provider/provider.dart';
import 'view_modal/provider/generalProvider/general_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: multiAppProviders,
      child: Consumer<GeneralProvider>(
        builder: (context, generalProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: RouteName.splashscreen,
            routes: RouteScreen.getScreens(),
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: generalProvider.themeMode,
          );
        },
      ),
    );
  }
}
