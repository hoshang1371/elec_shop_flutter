import 'package:elec_shop/network/networks.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, required this.orderId});
  final num orderId;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int _itemCount = 1;
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
          future: Network.getGetProductOrderList(tok, widget.orderId.toString()), // async work
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
                            itemCount: 10,
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
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              debugPrint("ok");
                                            },
                                            backgroundColor: Colors.red,
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
                                            child: const Image(
                                              //image: NetworkImage((products[index].imageUrl) ?? ""),
                                              image: AssetImage(
                                                  'assets/images/4_motor_4.jpg'),
                                              height: 50.0,
                                              width: 50.0,
                                            ),
                                          )),
                                    ],
                                  ),
                                  title: const Text(
                                    " باطری کتابی",
                                    style: TextStyle(
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
                                          child: FloatingActionButton.small(
                                            onPressed: () {
                                              setState(() {
                                                if (_itemCount != 0) {
                                                  _itemCount--;
                                                }
                                              });
                                            },
                                            backgroundColor: Colors.white,
                                            child: const Icon(
                                              Icons.remove,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(_itemCount.toString(),
                                          style:
                                              const TextStyle(fontSize: 20.0)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                        width: 30.0,
                                        child: FittedBox(
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              setState(() {
                                                _itemCount++;
                                              });
                                            },
                                            backgroundColor: Colors.white,
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.black,
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
                                  'قیمت کل : ${"10000".toPersianDigit()} تومان',
                                  style: const TextStyle(
                                    fontFamily: 'mikhak',
                                    fontSize: 16,
                                    color: Colors.red,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 150, // <-- match_parent
                                  height: 50, // <-- match-parent
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.greenAccent),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
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
                                    },
                                  ),
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
