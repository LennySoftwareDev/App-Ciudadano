import 'package:app_ciudadano/ui/downloadpdf/downloadpdf_screen.dart';
import 'package:app_ciudadano/ui/login/login_screen.dart';
import 'package:app_ciudadano/ui/profile/profile_screen.dart';
import 'package:app_ciudadano/ui/report/ireport/ireport_screen.dart';
import 'package:app_ciudadano/ui/walkthrough/walkthrough_screen.dart';
import 'package:app_ciudadano/utils/check_internet_connection.dart';
import 'package:app_ciudadano/utils/constants.dart';
import 'package:app_ciudadano/utils/utils.dart';
import 'package:app_ciudadano/di/dependency_injector.dart';
import 'package:flutter/material.dart';
import 'domain/models/user/notifications_service_model.dart';
import 'ui/home/home_screen.dart';
import 'ui/splash/splash_screen.dart';

final internetChecker = CheckInternetConnection();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await AppInjector.setUpInjector();

  PushNotificationService pushNotificationService = injector.resolve();
  await pushNotificationService.initializeMessageToken();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Ciudadano',
      theme: ThemeData(
        primarySwatch: Utils.getMaterialColorFromHex(AppConstants.primaryColor),
        scaffoldBackgroundColor:
            Utils.getColorFromHex(AppConstants.backgroundColor),
        fontFamily: "Ubuntu",
        inputDecorationTheme: const InputDecorationTheme().copyWith(
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 107, 106, 144), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      initialRoute: "login",
      routes: {
        "login": (BuildContext context) => const LoginScreen(),
        "home": (BuildContext context) => HomeScreen(),
        "splash": (BuildContext context) => SplashScreen(),
        "walkthrough": (BuildContext context) => WalkThroughScreen(),
        "profile": (BuildContext context) => ProfileScreen(),
        "report" :(BuildContext context) => IReportScreen(),
        "viewPDF" :(BuildContext context) => WebViewPage()
      },
    );
  }
}
