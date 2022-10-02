import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
//import 'package:elec_shop/json_user.dart';
//http://127.0.0.1:8000/core
//http://10.0.2.2:8000/core
//http://192.168.1.51:8000/api/api_token_auth/
test() async {
  var response = await http.get(Uri.parse("http://192.168.1.51:8000/core"));
  debugPrint(response.body);

  // http.get(Uri.parse("http://127.0.0.1:8000/core")).then((response) {
  //   debugPrint(response.statusCode.toString());
  //   // debugPrint(response.body);
  //   // print(response.body);
  // });
}


// void postDataLogin({
//   required String email,
//   required String password,
//   }) async {
//     User user = User(email:email,password:password);
//     //http.post(Network.url, body: user.toJson()).then((response) {
//       //print(response.body);
//     //});
//   }
