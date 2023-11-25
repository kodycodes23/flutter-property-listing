import 'package:firebase_auth/firebase_auth.dart';
import 'package:proptery/app/app_prefs.dart';
import 'package:proptery/presentation/login/login.dart';
//import 'package:proptery/app/di.dart';
import 'package:proptery/presentation/main/home/home_page.dart';
import 'package:proptery/presentation/resources/routes_manager.dart';
import 'package:proptery/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatefulWidget {
  MyApp._internal(); // private named constructor
  int appState = 0;
  static final MyApp instance =
      MyApp._internal(); // single instance -- singleton

  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return LoginView();
            }
          }));

  factory MyApp() => instance; // factory for the class instance

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //AppPreferences _appPreferences = instance<AppPreferences>();

  // void didChangeDependencies() {
  //   _appPreferences.getLocal().then((local) => {context.setLocale(local)});

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
