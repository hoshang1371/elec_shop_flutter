import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

//http://127.0.0.1:8000/core
//http://10.0.2.2:8000/core
test() async {
  var response = await http.get(Uri.parse("http://192.168.1.51:8000/core"));
  debugPrint(response.body);

  // http.get(Uri.parse("http://127.0.0.1:8000/core")).then((response) {
  //   debugPrint(response.statusCode.toString());
  //   // debugPrint(response.body);
  //   // print(response.body);
  // });
}
