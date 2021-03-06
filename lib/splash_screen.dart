import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_final/menu/menu_screen.dart';
import 'package:login_final/screens/login_screen.dart';
import 'package:login_final/utilities/constants.dart';

class SplashScreen extends StatefulWidget {
  final String email;
  const SplashScreen({Key? key, required this.email}) : super(key: key);
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget.email == ""
              ? const LoginScreen()
              : MenuScreen(dataEmail: widget.email),
        ));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6CA8F1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   child: Image.asset("images/logo.png"),
            // ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Silahkan Tunggu",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}
