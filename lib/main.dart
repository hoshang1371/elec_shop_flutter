// import 'dart:developer';
// import 'dart:io';

// import 'package:elec_shop/Screens/base_page.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'Screens/login_page.dart';
//import 'Screens/product_detail.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:search_app_bar_page/search_app_bar_page.dart';

//import 'Screens/product_list.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';


// final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    //context.loaderOverlay.show();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const LoginPage(),
      //home: const ProductDetails(),
      //home: const ProductList(),
      home: const LoaderOverlay(
        overlayColor: Colors.black,
        overlayOpacity: 0.8,
        //child: MyHomePage(),
        child: LoginPage(),
        //child: QRViewExample(),
        //child: BasePage(),
      ),
    );
  }
}



