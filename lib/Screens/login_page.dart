import 'package:elec_shop/network/networks.dart';
//import 'package:elec_shop/network/test.dart';
import "package:flutter/material.dart";

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:elec_shop/json_user.dart';

//import 'package:elec_shop/network/test.dart';

// import "package:google_fonts/google_fonts.dart";
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // final bool isKeyboardVisible =
    //     KeyboardVisibilityProvider.isKeyboardVisible(context);
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
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

                //*email text fild
                UserTextFeild(
                  text: "ایمیل",
                  controller: emailController,
                ),

                const SizedBox(
                  height: 10,
                ),
                //*password text fild
                UserTextFeild(
                  text: "پسوورد",
                  controller: passwordController,
                ),

                const SizedBox(
                  height: 25,
                ),

                //*login
                userLogin(),

                const SizedBox(
                  height: 25,
                ),
                //not a member?register now
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   // ignore: prefer_const_literals_to_create_immutables
                //   children: [
                //     Text(
                //       'Not a member?',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     Text(
                //       '  Register now',
                //       style: TextStyle(
                //         color: Colors.blue,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
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
          final user = User(
              email: emailController.text, password: passwordController.text);
          // debugPrint(emailController.text);
          // debugPrint(passwordController.text);
          final json = user.toJson();
          debugPrint("JSON: ${user.toJson()}");
          final newUser = User.fromJson(json);
          debugPrint('$newUser');
          //test();
          final network = Network();
          network.postDataLogin(
              email: emailController.text, password: passwordController.text);
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
