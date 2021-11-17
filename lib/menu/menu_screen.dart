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

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List data = List.empty();

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
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext _) => SplashScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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
