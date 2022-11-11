import 'package:cool_alert/cool_alert.dart';
import 'package:elec_shop/Data/order_data.dart';
import 'package:elec_shop/Data/user_data.dart';
import 'package:elec_shop/Screens/base_page.dart';
import 'package:elec_shop/network/networks.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, required this.orderId, required this.isPaid});
  final num orderId;
  final bool isPaid;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  // List<OrderList> ordrlist1 = ordrlist;
  // //ordrlist1.addAll(ordrlist1);
  // @override
  // void initState() {
  //   super.initState();
  //   // ordrlist1.addAll(ordrlist);
  //   print(ordrlist1);
  // }

  //OrderDetails.orderId =10;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "سبد خرید",
            style: TextStyle(
              fontFamily: 'mikhak',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          //future: Network.getOrderList(tok), // async work
          future: Network.getGetProductOrderList(
              tok, widget.orderId.toString()), // async work
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListView.builder(
                            itemCount: ordrlist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                // height: 50,
                                // width: 50,
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide()),
                                ),
                                child: ListTile(
                                  // ignore: deprecated_member_use
                                  leading: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 30.0,
                                        width: 30.0,
                                        child: FittedBox(
                                          child: !(widget.isPaid)
                                              ? FloatingActionButton(
                                                  onPressed: () {
                                                    debugPrint("ok2");
                                                    debugPrint(ordrlist[index]
                                                        .idOrder
                                                        .toString());
                                                    // setState(() {
                                                    CoolAlert.show(
                                                        context: context,
                                                        type: CoolAlertType
                                                            .confirm,
                                                        title:
                                                            "این محصول حذف شود؟",
                                                        // text:
                                                        //     'آیا از حذف این محصول مطمئن هستید؟',
                                                        confirmBtnText: 'بله',
                                                        cancelBtnText: 'خیر',
                                                        confirmBtnColor:
                                                            Colors.orange,
                                                        onConfirmBtnTap: () {
                                                          setState(() {
                                                            Network.deleteProductOrder(
                                                                tok,
                                                                ordrlist[index]
                                                                    .idOrder
                                                                    .toString());
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                  },
                                                  backgroundColor: Colors.red,
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : FloatingActionButton(
                                                  onPressed: () {
                                                    debugPrint("no ok");
                                                  },
                                                  backgroundColor:
                                                      Colors.red.shade100,
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      CircleAvatar(
                                          //radius: (52),
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image(
                                              image: NetworkImage(
                                                  (ordrlist[index]
                                                          .imageTumpnail) ??
                                                      ""),
                                              // image: AssetImage(
                                              //     'assets/images/4_motor_4.jpg'),
                                              height: 50.0,
                                              width: 50.0,
                                            ),
                                          )),
                                    ],
                                  ),
                                  title: Text(
                                    ordrlist[index].title,
                                    style: const TextStyle(
                                      fontFamily: 'mikhak',
                                      fontSize: 15,
                                    ),
                                  ),
                                  trailing: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 30.0,
                                        width: 30.0,
                                        child: FittedBox(
                                          // todo
                                          child: !(widget.isPaid)
                                              ? FloatingActionButton.small(
                                                  onPressed: () {
                                                    ordrlist[index].number--;
                                                    Network.postProduct(
                                                            token: tok,
                                                            count:
                                                                ordrlist[index]
                                                                    .number
                                                                    .toString(),
                                                            product:
                                                                ordrlist[index]
                                                                    .id
                                                                    .toString())
                                                        .then((value) {
                                                      setState(() {});
                                                    });
                                                  },
                                                  backgroundColor: Colors.white,
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              : FloatingActionButton.small(
                                                  onPressed: () {},
                                                  backgroundColor:
                                                      Colors.white70,
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          ordrlist[index]
                                              .number
                                              .toString()
                                              .toPersianDigit(),
                                          style:
                                              const TextStyle(fontSize: 20.0)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                        width: 30.0,
                                        child: FittedBox(
                                          child: !(widget.isPaid)
                                              ? FloatingActionButton(
                                                  onPressed: () {
                                                    ordrlist[index].number++;
                                                    Network.postProduct(
                                                            token: tok,
                                                            count:
                                                                ordrlist[index]
                                                                    .number
                                                                    .toString(),
                                                            product:
                                                                ordrlist[index]
                                                                    .id
                                                                    .toString())
                                                        .then((value) {
                                                      setState(() {});
                                                    });
                                                  },
                                                  backgroundColor: Colors.white,
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              : FloatingActionButton.small(
                                                  onPressed: () {},
                                                  backgroundColor:
                                                      Colors.white70,
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    debugPrint(index.toString());
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue),
                            //padding: const EdgeInsets.all(10),

                            child: Column(
                              children: [
                                Text(
                                  'قیمت کل : ${OrderList.allTotalPrice.toString().toPersianDigit()} تومان',
                                  style: const TextStyle(
                                    fontFamily: 'mikhak',
                                    fontSize: 16,
                                    color: Colors.red,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 150, // <-- match_parent
                                      height: 50, // <-- match-parent
                                      child: (widget.isPaid)
                                          ? const SizedBox.shrink()
                                          : ElevatedButton(
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.greenAccent),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    //side: BorderSide(color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                              child: const Text(
                                                "پرداخت",
                                                style: TextStyle(
                                                  fontFamily: 'mikhak',
                                                  fontSize: 20,
                                                  color: Colors.blueGrey,
                                                  //fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              onPressed: () {
                                                debugPrint("koko");
                                                Network.putIsPaidOrder(
                                                  tok,
                                                  widget.orderId.toString(),
                                                  UserData.userid,
                                                ).then((value) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const BasePage()));
                                                });
                                              },
                                            ),
                                    ),
                                    SizedBox(
                                      width: 150, // <-- match_parent
                                      height: 50, // <-- match-parent
                                      child: (widget.isPaid)
                                          ? const SizedBox.shrink()
                                          : ElevatedButton(
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.redAccent),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    //side: BorderSide(color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                              child: const Text(
                                                "حذف",
                                                style: TextStyle(
                                                  fontFamily: 'mikhak',
                                                  fontSize: 20,
                                                  color: Colors.white60,
                                                  //fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              onPressed: () {
                                                debugPrint("حذف");
                                                Network.deleteOrder(
                                                        tok,
                                                        widget.orderId
                                                            .toString())
                                                    .then((value) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const BasePage()));
                                                });
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
