//import 'package:elec_shop/Screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';

//import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:elec_shop/json_user.dart';
import 'dart:convert';
import 'dart:convert' as converter;

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:elec_shop/shared_preferences/shared_preferences_token.dart';

import 'dart:async';
//import 'dart:developer' as developer;
//import 'package:flutter/services.dart';
import '../Data/products_data.dart';

String tok = "";
const String uriImportant = "http://192.168.1.51:8000";

//  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
// token =  SharedPreferences.getInstance();
// final prefs = SharedPreferences.getInstance();
//"http://192.168.1.51:8000/api/api_token_auth/

class Network {
  static Uri url = Uri.parse("$uriImportant/api/api_token_auth/");
  static Uri urlGetProductList = Uri.parse("$uriImportant/api/");
  static Uri urlGetProductDitail = Uri.parse("$uriImportant/api");
  //static Uri urlGetProductList = Uri.parse("$uriImportant/api/");
  static Uri urlToken = Uri.parse("$uriImportant/api/Check_token/");
  //static String? tok;
  //! Check Internet

  static bool isConnected = false;

  //static ConnectivityResult _connectionStatus = ConnectivityResult.none;
  static final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  static Future<void> checkInternet(BuildContext context) async {
    late ConnectivityResult result;
    result = await _connectivity.checkConnectivity();

    Connectivity().onConnectivityChanged.listen((status) {
      if (status == ConnectivityResult.wifi ||
          status == ConnectivityResult.mobile) {
        isConnected = true;
      } else {
        showInternetError(context);
        isConnected = false;
      }
    });

    // ignore: use_build_context_synchronously
    return updateConnectionStatus(context, result);
  }

  // static Future<void> initConnectivity(BuildContext context) async {
  //   late ConnectivityResult result;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     developer.log('Couldn\'t check connectivity status', error: e);
  //     return;
  //   }

  //   // if (!mounted) {
  //   //   return Future.value(null);
  //   // }

  //   return updateConnectionStatus(context,result);
  // }

  static Future<void> updateConnectionStatus(
      BuildContext context, ConnectivityResult result) async {
    // setState(() {
    //_connectionStatus = result;
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      isConnected = true;
    } else {
      showInternetError(context);
      isConnected = false;
    }
    // });
  }

  //! Show Error Internet
  static void showInternetError(BuildContext context) {
    CoolAlert.show(
      width: 100,
      context: context,
      type: CoolAlertType.error,
      title: "خطا",
      confirmBtnText: "باشه",
      confirmBtnTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      confirmBtnColor: Colors.redAccent,
      text: 'شما به اینترنت متصل نیستید',
    );
  }

  //! Show Error Response Internet
  static void showInternetResponseError(BuildContext context) {
    CoolAlert.show(
      width: 100,
      context: context,
      type: CoolAlertType.error,
      title: "خطا",
      confirmBtnText: "باشه",
      confirmBtnTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      confirmBtnColor: Colors.redAccent,
      text: ' پاسخی از سرور دریافت نشد ',
    );
  }

  //! post login data and get Token
  static void postDataLogin({
    required String? email,
    required String? password,
  }) async {
    User user = User(email: email, password: password);
    var response = await http.post(Network.url, body: user.toJson());

    debugPrint(response.body);

    //response.body.contains('token');
    debugPrint("string is ${response.body.contains('token').toString()}");
    if (response.body.contains('token')) {
      addTokenStringToSF(response.body);
      var x = await getTokenStringValuesSF();
      debugPrint("Token Is $x");
    } else {
      debugPrint("Token is false");
    }
  }

  // static Future<void> updateConnectionStatus(
  //   BuildContext context, ConnectivityResult result)
//BuildContext context,
  //! check token
  static postDataToken(
    String token,
    BuildContext context,
  ) async {
    Map valueMap = jsonDecode(token);

    var response = await http.post(Network.urlToken, body: {
      "token": "${valueMap["token"]}"
    }, headers: {
      "Authorization": "Token ${valueMap["token"]}",
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      debugPrint("err");
      showInternetResponseError(context);
      return http.Response('Error', 500);
    });

    if (response.statusCode == 200) {
      debugPrint("*****************************");
      debugPrint(response.body);
      debugPrint(response.body.contains('"token":').toString());
      debugPrint(response.statusCode.toString());
      return (response.body);
      // if (response.body.contains('"token":')) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const LoginPage()),
      //   );
      // }
    } else {
      throw Exception('Album loading failed!');
    }
    // if (response.statusCode == 200) {
    //   debugPrint("ok 200");
    // } else {
    //   //debugPrint("err");
    //   throw Exception('Failed to load album');
    // }
  }

  //! Get pruduct list
  static Future<void> getGetProductList(
    /* Future<void> */
    String token,
  ) async {
    Map valueMap = jsonDecode(token);

    //contacts.clear();
    var response = await http.get(Network.urlGetProductList, headers: {
      "Authorization": "Token ${valueMap["token"]}",
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      debugPrint("err");
      //showInternetResponseError(context);
      return http.Response('Error', 500);
    });

    if (response.statusCode == 200) {
      //debugPrint("پاسخ");
      debugPrint(json.decode(utf8.decode(response.bodyBytes)).toString());
      // debugPrint(response.body);
      //List jsonDecode = converter.jsonDecode(response.body);
      List jsonDecode = converter.jsonDecode(utf8.decode(response.bodyBytes));

      for (var elements in jsonDecode) {
        //debugPrint(elements.toString());
        products.add(
          ProductListData(
            id: elements["id"],
            code: elements["code"],
            title: elements["title".toString()],
            place: elements["place"].toString(),
            number: num.parse(elements["number"].toString()),
            description: elements["description"].toString(),
            smallDescription: elements["smallDescription"].toString(),
            price: elements["price"].toString(),
            priceOff: elements["priceOff"].toString(),
            imageUrl: elements["image"],
            imageCumpnail: elements["image_tumpnail"],
            active: elements["active"],
            visitCount: elements["visit_count"],
            vige: elements["vige"],
            categories: elements["categories"],
          ),
        );
      }
      //debugPrint("ofter get ${products.length}");
      return;
    } else {
      throw Exception('Album loading failed!');
    }
  }

  //! Get pruduct detail
  static Future<void> getProductDetail(
    String token,
    String endPoint,
  ) async {
    Map valueMap = jsonDecode(token);

    //contacts.clear();

    var response = await http
        .get(Uri.parse('${Network.urlGetProductDitail}/$endPoint'), headers: {
      "Authorization": "Token ${valueMap["token"]}",
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      debugPrint("err");
      //showInternetResponseError(context);
      return http.Response('Error', 500);
    });
    if (response.statusCode == 200) {
      debugPrint(utf8.decode(response.bodyBytes));
      //List jsonDecode = converter.jsonDecode(utf8.decode(response.bodyBytes));
      Map detailMap = jsonDecode(utf8.decode(response.bodyBytes));

      debugPrint(detailMap["smallDescription"]);

      ProductDetailData.getAll(detailMap);
    }
  }

  //! Get Searsh pruduct list
  //static Future<void> getSearchProductList(
  static Future getSearchProductList(
    String token,
    String searh,
  ) async {
    Map valueMap = jsonDecode(token);

    //contacts.clear();

    var response = await http.get(
        //Uri.parse('${Network.urlGetProductDitail}/questions/?search=$searh'),
        Uri.parse('${Network.urlGetProductDitail}/questions/?search=$searh'),
        headers: {
          "Authorization": "Token ${valueMap["token"]}",
        }).timeout(const Duration(seconds: 10), onTimeout: () {
      debugPrint("err");
      //showInternetResponseError(context);
      return http.Response('Error', 500);
    });
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      debugPrint(utf8.decode(response.bodyBytes));
      List jsonDecode = converter.jsonDecode(utf8.decode(response.bodyBytes));

      for (var elements in jsonDecode) {
        debugPrint(elements.toString());
        searchProducts.add(
          ProductListData(
            id: elements["id"],
            code: elements["code"],
            title: elements["title".toString()],
            place: elements["place"].toString(),
            number: num.parse(elements["number"].toString()),
            description: elements["description"].toString(),
            smallDescription: elements["smallDescription"].toString(),
            price: elements["price"].toString(),
            priceOff: elements["priceOff"].toString(),
            imageUrl: elements["image"],
            imageCumpnail: elements["image_tumpnail"],
            active: elements["active"],
            visitCount: elements["visit_count"],
            vige: elements["vige"],
            categories: elements["categories"],
          ),
        );
      }
      //debugPrint("ofter get ${products.length}");
      return;
      // Map detailMap = jsonDecode(utf8.decode(response.bodyBytes));

      // debugPrint(detailMap["smallDescription"]);

      // ProductDetailData.getAll(detailMap);

    }
    else {
      throw Exception('Album loading failed!');
    }
  }
}

/*
Avoid using braces in interpolation when not needed.

*/
