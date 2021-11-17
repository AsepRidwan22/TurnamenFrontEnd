import 'package:flutter/material.dart';
import 'package:login_final/screens/login_screen.dart';
import 'package:login_final/register/register_screen.dart';
import 'package:login_final/menu/menu_screen.dart';
import 'package:login_final/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences sp = await SharedPreferences.getInstance();
  // var email = sp.getString('email');
  // runApp(MyApp(dataEmail: jsonEncode(email)));

  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final sp = await _prefs;
  String email = "";
  try {
    email = sp.getString('email') ?? "";
    print("sp ada");
  } catch (e) {
    print(e);
  }

  runApp(MyApp(dataEmail: email));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String dataEmail;

  const MyApp({Key? key, required this.dataEmail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      routes: {
        // '/': (BuildContext _) => LoginScreen(),
        '/': (BuildContext _) => SplashScreen(
              email: dataEmail,
            ),
        '/register': (BuildContext _) => RegisterScreen(),
        // '/menu': (BuildContext _) => SplashScreen(),
      },
      // home: LoginScreen(),
      initialRoute: '/',
    );
  }
}
