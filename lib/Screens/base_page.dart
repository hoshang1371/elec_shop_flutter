// import 'package:elec_shop/Data/products_data.dart';
import 'package:elec_shop/Data/order_data.dart';
import 'package:elec_shop/Screens/order_list_details.dart';
import 'package:elec_shop/Screens/order_list.dart';
import 'package:elec_shop/Screens/product_list.dart';
// import 'package:elec_shop/extentions/build_my_nav_bar.dart';
// import 'package:elec_shop/extentions/list_view.dart';
import 'package:elec_shop/extentions/qr_code_view.dart';
import 'package:elec_shop/extentions/search_view.dart';
import 'package:elec_shop/network/networks.dart';
import 'package:flutter/material.dart';
// import 'package:elec_shop/network/test.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  static int pageIndex = 0;
  static String title = "خانه";

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final pages = [
    const Page1(),
    const QRPage(),
    const PageListViewProduct(),
    const OrderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Colors.black,
      overlayOpacity: 0.8,
      child: SafeArea(
        child: Scaffold(
          //backgroundColor: const Color(0xffC4DFCB),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              BasePage.title,
              style: const TextStyle(
                fontFamily: 'mikhak',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(),
                  );
                },
              ),
            ],
          ),
          body: pages[BasePage.pageIndex],
          bottomNavigationBar: buildMyNavBar(context),
        ),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                BasePage.pageIndex = 0;
                BasePage.title = "خانه";
                //pageIndex = 0;
              });
            },
            icon: BasePage.pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                BasePage.pageIndex = 1;
                BasePage.title = "بار کد خوان";
              });
            },
            icon: BasePage.pageIndex == 1
                ? const Icon(
                    Icons.qr_code,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.qr_code_scanner_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                BasePage.pageIndex = 2;
                BasePage.title = " لیست محصولات ";
              });
            },
            icon: BasePage.pageIndex == 2
                ? const Icon(
                    Icons.storage_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.format_list_bulleted_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                BasePage.pageIndex = 3;
                BasePage.title = " سبدهای خرید مشتریان";
              });
            },
            icon: BasePage.pageIndex == 3
                ? const Icon(
                    Icons.local_mall,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.local_mall_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 1",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class QRPage extends StatelessWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const QRViewExample();
  }
}


