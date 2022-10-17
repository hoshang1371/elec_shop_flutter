import 'package:elec_shop/Data/products_data.dart';
import 'package:elec_shop/Screens/product_list.dart';
import 'package:elec_shop/network/networks.dart';
//import 'package:elec_shop/network/test.dart';
import "package:flutter/material.dart";

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:elec_shop/json_user.dart';
import 'package:elec_shop/shared_preferences/shared_preferences_token.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'dart:async';
// import 'dart:developer' as developer;
// import 'package:flutter/services.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

// String? tok;
late StreamSubscription<ConnectivityResult> _connectivitySubscription;

Future<String> getValue(BuildContext context) async {
  //final network = Network();
  // String? bodyResponse;
  getTokenStringValuesSF().then((token) {
    debugPrint("token $token");

    Network.checkInternet(context).then((value) {
      if (Network.isConnected == true) {
        Network.postDataToken(token, context).then((val) {
          // debugPrint("val $val");
          tok = val;
          debugPrint("tok $tok");
          if (tok.contains('"token":')) {
            // Network.getGetProductList(tok);
            //Network.getGetProductDetail(tok);
            Network.getGetProductList(tok).then((value1) {
              debugPrint(products.length.toString());
              debugPrint("ok");
              // TODO
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductList()),
              );
            });
          }
        });
      }
    });
  });
  await Future.delayed(const Duration(seconds: 3), () {});

  return 'Flutter Devs';
}

// getData(BuildContext context) {
//   getTokenStringValuesSF().then((value) {
//     debugPrint(value);
//     tok = value;
//     debugPrint("tok");
//     debugPrint(tok);
//     Network.postDataToken(value,context);
//   });
//   // await Future.delayed(Duration(seconds: 3));
//   // return 'Flutter Devs';
// }

Future<String>? value;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    value = getValue(context);

    // Network.initConnectivity();

    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(Network.updateConnectionStatus);
  }

  @override
  dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // final bool isKeyboardVisible =
    //     KeyboardVisibilityProvider.isKeyboardVisible(context);
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: FutureBuilder(
            future: value,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // (isKeyboardVisible)? Text(
                      //   'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}',
                      // ):
                      isKeyboardVisible
                          ? const SizedBox.shrink()
                          : const Text(
                              "سلام",
                              style: TextStyle(
                                fontFamily: 'mikhak',
                                fontSize: 52,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      isKeyboardVisible
                          ? const SizedBox.shrink()
                          : const Text(
                              'به نرم افزار مدیریت فروشگاه اسپاد خوش آمدید',
                              style: TextStyle(
                                fontFamily: 'mikhak',
                                fontSize: 20,
                              ),
                            ),
                      const SizedBox(
                        height: 50,
                      ),

                      //email text fild
                      UserTextFeild(
                        text: "ایمیل",
                        controller: emailController,
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      //password text fild
                      UserTextFeild(
                        text: "پسوورد",
                        controller: passwordController,
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //login
                      userLogin(),

                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
    });
  }

  Padding userLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      //ElevatedButton
      child: ElevatedButton(
        onPressed: () {
          //context.loaderOverlay.show();
          // Network.showInternetError(context);

          final user = User(
            email: emailController.text,
            password: passwordController.text,
          );
          // debugPrint(emailController.text);
          // debugPrint(passwordController.text);
          // final json = user.toJson();
          // debugPrint("JSON: ${user.toJson()}");
          // final newUser = User.fromJson(json);
          // debugPrint('$newUser');
          //test();
          //final network = Network();

          // network.postDataLogin(
          //   email: emailController.text,
          //   password: passwordController.text,
          // );
          Network.postDataLogin(
            email: user.email,
            password: user.password,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.deepPurple, //change background color of button
          foregroundColor: Colors.yellow, //change text color of button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 15.0,
        ),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: const Center(
            child: Text(
              'ورود',
              style: TextStyle(
                fontFamily: 'mikhak',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ), //888
      ),
    );
  }
}

class UserTextFeild extends StatelessWidget {
  const UserTextFeild({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);

  final String text;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: TextField(
            controller: controller,
            obscureText: (controller == passwordController) ? true : false,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              hintTextDirection: TextDirection.rtl,
              hintStyle: const TextStyle(
                fontFamily: 'mikhak',
              ),
            ),
          ),
        ),
      ),
    );
  }
}




/*

Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // (isKeyboardVisible)? Text(
                //   'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}',
                // ):
                isKeyboardVisible
                    ? const SizedBox.shrink()
                    : const Text(
                        "سلام",
                        style: TextStyle(
                          fontFamily: 'mikhak',
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                isKeyboardVisible
                    ? const SizedBox.shrink()
                    : const Text(
                        'به نرم افزار مدیریت فروشگاه اسپاد خوش آمدید',
                        style: TextStyle(
                          fontFamily: 'mikhak',
                          fontSize: 20,
                        ),
                      ),
                const SizedBox(
                  height: 50,
                ),

                //email text fild
                UserTextFeild(
                  text: "ایمیل",
                  controller: emailController,
                ),

                const SizedBox(
                  height: 10,
                ),
                //password text fild
                UserTextFeild(
                  text: "پسوورد",
                  controller: passwordController,
                ),

                const SizedBox(
                  height: 25,
                ),

                //login
                userLogin(),

                const SizedBox(
                  height: 25,
                ),

              ],
            ),
          ),


*/ 