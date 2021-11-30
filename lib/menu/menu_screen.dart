// import 'package:flutter/cupertino.dart';
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:login_final/network_utils/api.dart';
import 'package:login_final/splash_screen.dart';
import 'package:login_final/utilities/constants.dart';
import 'package:login_final/screens/login_screen.dart';
import 'package:login_final/menu/form/ubah.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  final String dataEmail;
  const MenuScreen({Key? key, required this.dataEmail}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List data = List.empty();

  Future logout() async {
    WidgetsFlutterBinding.ensureInitialized();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final sp = await _prefs;
    sp.remove('email');
    // Fluttertoast.showToast(
    //     msg: "BERHASIL LOGOUT",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Logout Berhasil")));

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext _) => LoginScreen()));
  }

  Future<String> getData() async {
    var res = await Network().getData('/showall');
    var body = json.decode(res.body);

    if (body['status'] == 1) {
      print(body['data']);
      setState(() {
        data = body['data'];
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Gagal mengambil data")));
    }
    return "";
  }

  @override
  void initState() {
    getData();
  }

  void delete(id) async {
    var res = await Network().deleteData('/delete/' + id.toString());
    var body = json.decode(res.body);
    print(id);
    if (body['status'] != null) {
      final sp = await SharedPreferences.getInstance();
      String? emailUser = sp.getString('email');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext _) => SplashScreen(
                email: emailUser!,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          elevation: 20.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Asep Ridwan'),
                accountEmail: Text(widget.dataEmail),
                currentAccountPicture: Row(
                  children: <Widget>[
                    Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: Colors.teal,
                              width: 4.0,
                              style: BorderStyle.solid),
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://scontent.fbdo5-1.fna.fbcdn.net/v/t1.6435-9/118659688_2541284479490751_9204819832067911218_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeFg-a55VsEU20aSk0hkwDdtII4JEohV6nsgjgkSiFXqew0QwSm3sJCGrAwd3z9hQG6YfyPkOGwbAWsMY_CGpK-u&_nc_ohc=joifg9q4UfAAX9HCArg&_nc_oc=AQkPdVQ-JvG_QjvWl1ODgQukNbwYwe9YmmUMgVsrc8d0a7azafbnWE15dBJJOeFv8jo&_nc_ht=scontent.fbdo5-1.fna&oh=c13f3669794b50950bc213d364f8c480&oe=61C21F29'))),
                    ),
                  ],
                ),
                decoration: kBoxDecorationStyle,
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('LOGOUT'),
                onTap: () => logout(),
              ),
              // Divider(
              //   height: 2.0,
              // ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Item '),
                onTap: () {
                  // This line code will close drawer programatically....
                  Navigator.pop(context);
                },
              ),
              Divider(
                height: 2.0,
              ),
            ],
          )),
      appBar: AppBar(
        title: Text(
          'HOME',
          textAlign: TextAlign.center,
          // style: TextStyle(color: Colors.black87),
        ),
        // backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: data.isEmpty ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                height: 100,
                color: Colors.white,
                child: Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Expanded(
                          child: CircleAvatar(
                            child: Text(data[index]['name'][0]),
                          ),
                          flex: 2,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ListTile(
                                title: Text(data[index]['name']),
                                subtitle: Text(data[index]['email']),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text("Ubah"),
                                    onPressed: () {
                                      print(data[index]);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext _) =>
                                                  UbahScreen(
                                                      dataEdit: jsonEncode(
                                                          data[index]))));
                                    },
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Hapus",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () => delete(data[index]['id']),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      flex: 8,
                    ),
                  ],
                ),
              ),
              elevation: 8,
              margin: EdgeInsets.all(10),
            );
          }),
    );
  }
}
// class MenuScreen extends StatefulWidget {
//   // User user;
//   // MenuScreen({this.user});
//   @override
//   _MenuScreenState createState() => _MenuScreenState(); //(this.user);
// }

// class User {}

// class _MenuScreenState extends State<MenuScreen> {
//   final User user;
//   _MenuScreenState(this.user);
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff151515),
//       appBar: AppBar(
//         title: Text('Detail Student'),
//         backgroundColor: Color(0xff151515),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(24),
//           child: Card(
//             elevation: 4.0,
//             color: Colors.blue[700],
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         // "${user.id}",
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 24),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         // "${user.name}",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Text(
//                         // "${user.role}",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(height: 24),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Date of Birth: ",
//                         style: TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                       Text(
//                         // "${user.image}",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
