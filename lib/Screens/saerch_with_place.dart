import 'package:elec_shop/Data/products_data.dart';
import 'package:elec_shop/extentions/list_view.dart';
import 'package:elec_shop/network/networks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResultOfSearchWithPalce extends StatefulWidget {
  const ResultOfSearchWithPalce({super.key, required this.placeCode});
  final String placeCode;
  @override
  State<ResultOfSearchWithPalce> createState() =>
      _ResultOfSearchWithPalceState();
}

class _ResultOfSearchWithPalceState extends State<ResultOfSearchWithPalce> {
  @override
  void initState() {
    super.initState();
    debugPrint("widget.placeCode");
    //! به هنگام ارسال از qr code view اطلاعات خالی را میفرستد
    debugPrint(widget.placeCode);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("کالاهای دارای این کد مکان"),
          centerTitle: true,
        ),
        body: ListViewProduct(
          productslistViewProduct: searchProductsWithPlace,
          f: Network.getSearchProductWithOnlyplaceList(tok, widget.placeCode),
          //f: Network.getSearchProductList(tok, 'برد'),
        ),
        // body: Center(
        //     child: ListViewProduct(
        //   productslistViewProduct: searchProductsWithPlace,
        //   f: Network.getSearchProductWithOnlyplaceList(tok, "5050"),
        //   //f: Network.getSearchProductList(tok, 'برد'),
        // ),
        // ),
      ),
    );
  }
}
