import 'dart:ui';

import 'package:elec_shop/Screens/base_page.dart';
import 'package:elec_shop/network/networks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../Data/products_data.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  num numberofProduct = 1;
  TextEditingController nameController = TextEditingController();
  void clearText() {
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("جزئیات محصولات"),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                (isKeyboardVisible)
                    ? const SizedBox.shrink()
                    : Image(
                        image: NetworkImage(ProductDetailData.imageUrl ?? ""),
                        // image: const AssetImage(
                        //   "assets/images/4_motor_4.jpg",
                        // ),
                        width: size.width,
                        height: size.height / 3,
                      ),
                // const SizedBox(
                //   height: 40,
                // ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrangeAccent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "${ProductDetailData.price.toPersianDigit()} تومان",
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (ProductDetailData.priceOff
                                        .toPersianDigit() !=
                                    "null")
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 1,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "فروش ویژه  ${(ProductDetailData.priceOff.toPersianDigit())} تومان",
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              //color: Colors.red,
                              child: Text(
                                textAlign: TextAlign.right,
                                ":نام محصول \n ${ProductDetailData.title} ",
                                style: const TextStyle(
                                  fontFamily: 'mikhak',
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "${ProductDetailData.place.toPersianDigit()}: مکان کالا",
                          style: const TextStyle(
                              fontFamily: 'mikhak',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "${ProductDetailData.number.toString().toPersianDigit()}:تعداد موجود در انبار",
                          style: const TextStyle(
                              fontFamily: 'mikhak',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              textAlign: TextAlign.center,
                              "تومان",
                              style: TextStyle(
                                  fontFamily: 'mikhak',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            ),
                            //if (ProductDetailData.priceOff.toPersianDigit() !="null")
                            Text(
                              textAlign: TextAlign.center,
                              (ProductDetailData.priceOff != "null")
                                  ? "${(numberofProduct * int.parse(ProductDetailData.priceOff)).toString().toPersianDigit()} :قیمت کل "
                                  : "${(numberofProduct * int.parse(ProductDetailData.price)).toString().toPersianDigit()} :قیمت کل ",
                              style: const TextStyle(
                                  fontFamily: 'mikhak',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: size.width / 2,
                              height: 70,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (--numberofProduct < 1) {
                                          numberofProduct = 1;
                                        }
                                        nameController.text = numberofProduct
                                            .toString()
                                            .toPersianDigit();
                                      });
                                      // print("-");
                                    },
                                    child: CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.grey.shade900,
                                      child: const Icon(Icons.remove),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 60,
                                    child: TextField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: numberofProduct
                                            .toString()
                                            .toPersianDigit(),
                                        contentPadding: const EdgeInsets.only(
                                          bottom: 7.0,
                                        ),
                                        focusColor: Colors.black,
                                        // filled: true,
                                        // fillColor: Colors.red,
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'mikhak',
                                        fontSize: 20,
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onEditingComplete: () {
                                        nameController.text = nameController
                                            .text
                                            .toPersianDigit();
                                      },
                                      onTap: () => clearText(),

                                      onChanged: (text) {
                                        numberofProduct = int.parse(
                                            nameController.text
                                                .toEnglishDigit());
                                      },
                                    ),
                                  ),
                                  // Text(
                                  //   numberofProduct.toString().toPersianDigit(),
                                  //   style: const TextStyle(
                                  //     fontFamily: 'mikhak',
                                  //     fontSize: 20,
                                  //   ),
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        ++numberofProduct;
                                        nameController.text = numberofProduct
                                            .toString()
                                            .toPersianDigit();
                                      });
                                      // print("+");
                                    },
                                    child: CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.grey.shade900,
                                      child: const Icon(Icons.add),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  debugPrint("olo");
                                  //todo nameController.text

                                  Network.postProduct(
                                          token: tok,
                                           count: numberofProduct.toString(),
                                          //count: nameController.text,
                                          product:
                                              ProductDetailData.id.toString())
                                      .then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BasePage()));
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.grey.shade900),
                                  fixedSize: MaterialStateProperty.all(
                                    const Size(double.infinity, 50),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                ),
                                child: const Text("اضافه به سبد",
                                    style: TextStyle(
                                      fontFamily: 'mikhak',
                                      fontSize: 20,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
