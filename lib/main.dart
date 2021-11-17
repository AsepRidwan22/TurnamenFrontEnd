import 'package:flutter/material.dart';
import 'package:login_final/screens/login_screen.dart';
import 'package:login_final/register/register_screen.dart';
import 'package:login_final/menu/menu_screen.dart';
import 'package:login_final/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (BuildContext _) => LoginScreen(),
        '/register': (BuildContext _) => RegisterScreen(),
        '/menu': (BuildContext _) => SplashScreen(),
      },
      // home: LoginScreen(),
      initialRoute: '/',
    );
  }
}
