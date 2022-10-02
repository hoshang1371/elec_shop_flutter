//import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:elec_shop/json_user.dart';

const String uriImportant = "http://192.168.1.51:8000";

//"http://192.168.1.51:8000/api/api_token_auth/
class Network {
  static Uri url = Uri.parse("$uriImportant/api/api_token_auth/");

  void postDataLogin({
    required String? email,
    required String? password,
  }) async {
    User user = User(email: email, password: password);
    var response = await http.post(Network.url, body: user.toJson());
    debugPrint(response.body);
    // http.post(Network.url, body: user.toJson()).then((response) {
    //   debugPrint(response.body);
    // });
  }
}


/*
Avoid using braces in interpolation when not needed.

*/
