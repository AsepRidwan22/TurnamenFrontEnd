// import 'package:login_final/menu/model_user.dart';
// import 'package:login_final/network_utils/api.dart';
// import 'dart:convert';

// class StudentService {
//   static String baseUrl = "/student";

//   static Future<List<User>> getUser() async {
//     final response = await Network().getData(baseUrl);
//     List<User> list = parseResponse(response.body);
//     return list;
//   }

//   static List<User> parseResponse(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<User>((json) => User.fromJson(json)).toList();
//   }
// }
