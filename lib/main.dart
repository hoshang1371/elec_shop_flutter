import 'package:flutter/material.dart';

import 'Screens/login_page.dart';
//import 'Screens/product_detail.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:search_app_bar_page/search_app_bar_page.dart';

// // import 'Screens/product_list.dart';



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
      home: const LoginPage(),
      //home: const ProductDetails(),
      //home: const ProductList(),

    );
  }
}
