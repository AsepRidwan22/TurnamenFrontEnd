import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_final/network_utils/api.dart';
import 'package:login_final/utilities/constants.dart';
import 'package:login_final/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "", password = "", role = "", name = "", image = "";
  // final _picker = ImagePicker();
  // late File _image;
  File foto = File("");

  void register() async {
    var data = {
      'email': email,
      'password': password,
      'role': role,
      'name': name,
      'image': image
    };

    var res = await Network().authData(data, '/register');
    var body = json.decode(res.body);

    print(body);
    if (body['status'] == 1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Register Berhasil")));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext _) => LoginScreen()));
    } else {
      var pesanError = "";
      if (body['reason'] != null) {
        pesanError = body['reason'][0];
      } else {
        pesanError = "Gagal Register";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(pesanError)));
    }
  }

  Future getImage(ImageSource media) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: media);

    setState(() {
      if (image != null) {
        foto = File(image.path);
        // final _imageFile = ImageProcess.decodeImage(
        //   foto.readAsBytesSync(),
        // );
        // print("image masuk");
      } else {
        print("No image selected");
      }
    });
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
            onChanged: (value) => role = value,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.refresh_rounded, color: Colors.white),
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
            onChanged: (value) => name = value,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.person_sharp, color: Colors.white),
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
          height: 80.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () => _showPicker(context),
                  padding: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Colors.white,
                  child: Text(
                    'Choose Image',
                    style: TextStyle(
                        color: Color(0xFF527DAA),
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans'),
                  ),
                ),
              ),
              Container(
                width: 70.0,
                height: 70.0,
                // child: foto != null
                //     ? Image.file(
                //         foto,
                //         fit: BoxFit.fill,
                //       )
                //     : Text("test")
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.blue,
                        width: 4.0,
                        style: BorderStyle.solid),
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://scontent.fbdo5-1.fna.fbcdn.net/v/t1.6435-9/118659688_2541284479490751_9204819832067911218_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeFg-a55VsEU20aSk0hkwDdtII4JEohV6nsgjgkSiFXqew0QwSm3sJCGrAwd3z9hQG6YfyPkOGwbAWsMY_CGpK-u&_nc_ohc=joifg9q4UfAAX9HCArg&_nc_oc=AQkPdVQ-JvG_QjvWl1ODgQukNbwYwe9YmmUMgVsrc8d0a7azafbnWE15dBJJOeFv8jo&_nc_ht=scontent.fbdo5-1.fna&oh=c13f3669794b50950bc213d364f8c480&oe=61C21F29'))),
                // // image: foto != null ? Image.file(foto, fit: BoxFit.fill,)Text("test");
              ),
            ],
          ),
        ),
      ],
    );
  }

  _imgFromCamera() async {
    // final pickedimage =
    //     await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    // File imagefile = new File(pickedimage.path);

    getImage(ImageSource.camera);
    //  setState(() {
    //   // _image = imagefile;
    //   List<int> imageBytes = imagefile.readAsBytesSync();
    //   String base64Image = base64Encode(imageBytes);
    //   image = base64Image;
    //   print("image masuk");
    // });
  }

  _imgFromGallery() async {
    // final pickedimage =
    //     await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    // File imagefile = File(pickedimage.toString());

    // setState(() {
    //   _image = imagefile;
    //   List<int> imageBytes = imagefile.readAsBytesSync();
    //   String base64Image = base64Encode(imageBytes);
    //   image = base64Image;
    //   print("image masuk");
    // });

    getImage(ImageSource.gallery);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Widget _showImage() {
  //   return Container(
  //     width: 200,
  //     height: 200,
  //     color: Colors.black26,
  //     child: foto != null
  //         ? image.file(
  //             foto,
  //             fit: BoxFit.fill,
  //           )
  //         : Text("test"),
  //   );
  // }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => register(),
        padding: EdgeInsets.all(15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.white,
        child: Text(
          'REGISTER',
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
                  _buildRegisterBtn()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
