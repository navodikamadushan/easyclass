// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:easyclass/shared/splash.dart';
import 'package:easyclass/screens/wrapper.dart';
import 'package:provider/provider.dart';
import "package:easyclass/services/auth.dart";
import 'package:easyclass/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import "package:easyclass/services/provider/list_provider.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue.shade300,
          dividerColor: Colors.black,
        ),
        home: AnimatedSplashScreen(
          splash: Splash(),
          duration: 1000,
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: Colors.purple[100],
          nextScreen: Wrapper(),
        ),
      ),
    );
  }
}
