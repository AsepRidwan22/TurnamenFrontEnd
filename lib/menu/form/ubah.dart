// import 'package:flutter/cupertino.dart';
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_final/network_utils/api.dart';
import 'package:login_final/utilities/constants.dart';
import 'package:login_final/menu/menu_screen.dart';
import 'package:login_final/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UbahScreen extends StatefulWidget {
  final String dataEdit;
  const UbahScreen({Key? key, required this.dataEdit}) : super(key: key);

  @override
  _UbahScreenState createState() => _UbahScreenState();
}

class _UbahScreenState extends State<UbahScreen> {
  int id = 0;
  String email = "", password = "", role = "", name = "", image = "";
  late Map<String, dynamic> dataNew;
  final _controllerEmail = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerRole = TextEditingController();
  final _controllerImage = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataNew = json.decode(widget.dataEdit);
    id = dataNew['id'] ?? 0;
    email = dataNew['email'] ?? "";
    name = dataNew['name'] ?? "";
    role = dataNew['role'] ?? "";
    image = dataNew['image'] ?? "";

    _controllerEmail.text = dataNew['email'] ?? "";
    _controllerName.text = dataNew['name'] ?? "";
    _controllerRole.text = dataNew['role'] ?? "";
    _controllerImage.text = dataNew['image'] ?? "";
  }

  void update() async {
    var data = {
      'email': email,
      'pasword': password,
      'role': role,
      'name': name,
      'image': image
    };

    var res = await Network().authData(data, '/update/' + id.toString());
    var body = json.decode(res.body);

    print(body);
    if (body['status'] == 1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Update Berhasil")));
      final sp = await SharedPreferences.getInstance();
      String? emailUser = sp.getString('email');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext _) => SplashScreen(
                email: emailUser!,
              )));
    } else {
      var pesanError = "";
      if (body['reason'] != null) {
        pesanError = body['reason'];
      } else {
        pesanError = "Gagal Update";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(pesanError)));
    }
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _controllerEmail,
            onChanged: (value) => email = value,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.email, color: Colors.white),
              hintText: 'Enter Your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            onChanged: (value) => password = value,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.lock, color: Colors.white),
              hintText: 'Enter Your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoleTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Role',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _controllerRole,
            onChanged: (value) => role = value,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.email, color: Colors.white),
              hintText: 'Enter Your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _controllerName,
            onChanged: (value) => name = value,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.email, color: Colors.white),
              hintText: 'Enter Your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Image',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _controllerImage,
            onChanged: (value) => image = value,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.email, color: Colors.white),
              hintText: 'Enter Your Image',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => update(),
        padding: EdgeInsets.all(15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.white,
        child: Text(
          'Update',
          style: TextStyle(
              color: Color(0xFF527DAA),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 60.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildEmailTF(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildPasswordTF(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildRoleTF(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildNameTF(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildImageTF(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildUpdateBtn()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
