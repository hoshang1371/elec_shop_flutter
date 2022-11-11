import 'package:elec_shop/Data/order_data.dart';
import 'package:elec_shop/Screens/order_list_details.dart';
import 'package:elec_shop/network/networks.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Network.getOrderList(tok), // async work
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            // return Text('Loading....');
            order.clear();
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
                        reverse: true,
                        itemCount: order.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide()),
                            ),
                            child: ListTile(
                              // ignore: deprecated_member_use
                              title: Text(
                                // ignore: deprecated_member_use
                                order[index].paymentDate.toPersinaDate(),
                                style: const TextStyle(
                                  fontFamily: 'mikhak',
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                OrderListData.spliteSpace(
                                        order[index].jPaymentDate)
                                    .time
                                    .toPersianDigit(),
                                style: const TextStyle(
                                  fontFamily: 'mikhak',
                                  fontSize: 15,
                                ),
                              ),
                              trailing: Text(
                                (order[index].isPaid)
                                    ? "پرداخت شده"
                                    : "پرداخت نشده",
                                style: TextStyle(
                                  color: (order[index].isPaid)
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'mikhak',
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {
                                debugPrint(order[index].id.toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetails(
                                            orderId: order[index].id,
                                            isPaid: order[index].isPaid,
                                          )),
                                );
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
                      child: SizedBox(
                        width: double.infinity, // <-- match_parent
                        height: 50, // <-- match-parent
                        child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                //side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          child: const Text(
                            "آخرین سبد خرید ",
                            style: TextStyle(
                              fontFamily: 'mikhak',
                              fontSize: 20,
                              color: Colors.black,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            for (var ord in order) {
                              if (ord.isPaid == false) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetails(
                                            orderId: ord.id,
                                            isPaid: ord.isPaid,
                                          )),
                                );
                              }
                            }

                            debugPrint("koko1");
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
        }
      },
    );
  }
}
