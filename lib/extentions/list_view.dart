import 'package:flutter/material.dart';

import 'package:elec_shop/network/networks.dart';

import 'package:elec_shop/Screens/product_detail.dart';

import '../Data/products_data.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ListViewProduct extends StatefulWidget {
  ListViewProduct({
    Key? key,
    required this.productslistViewProduct,
    required this.f,
  }) : super(key: key);

  List<ProductListData> productslistViewProduct = <ProductListData>[];
  Future f;
  @override
  State<ListViewProduct> createState() => _ListViewProductState();
}

class _ListViewProductState extends State<ListViewProduct> {
  //final int g;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.f, // async work
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            widget.productslistViewProduct.clear();
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                // shrinkWrap: true,
                itemCount: widget.productslistViewProduct.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: ListTile(
                      //leading: const Icon(Icons.list),
                      leading: CircleAvatar(
                          radius: (52),
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image(
                              //image: NetworkImage((products[index].imageUrl) ?? ""),
                              image: NetworkImage((widget
                                      .productslistViewProduct[index]
                                      .imageCumpnail) ??
                                  ""),
                              height: 50.0,
                              width: 50.0,
                            ),
                          )),
                      trailing: Text(
                        (widget.productslistViewProduct[index].active)
                            ? "فعال"
                            : "غیر فعال",
                        style: (widget.productslistViewProduct[index].active)
                            ? const TextStyle(color: Colors.green, fontSize: 15)
                            : const TextStyle(color: Colors.red, fontSize: 15),
                      ),
                      title: Text(
                        widget.productslistViewProduct[index].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'mikhak',
                          fontSize: 16,
                        ),
                      ),
                      //TODO
                      onTap: () {
                        context.loaderOverlay.show();
                        // debugPrint("hhhhh");
                        Network.getProductDetail(
                                tok,
                                widget.productslistViewProduct[index].id
                                    .toString())
                            .then((value) => {
                                  context.loaderOverlay.hide(),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProductDetails()),
                                  )
                                });
                      },
                    ),
                  );
                },
              );
            }
        }
      },
    );
    // return FutureBuilder(
    //   builder: (context, projectSnap) {
    //     if (projectSnap.connectionState == ConnectionState.none &&
    //         projectSnap.hasData == null) {
    //       //print('project snapshot data is: ${projectSnap.data}');
    //       return Container();
    //     }
    //     return ListView.builder(
    //       itemCount: widget.productslistViewProduct.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         return Container(
    //           decoration: const BoxDecoration(
    //             border: Border(bottom: BorderSide()),
    //           ),
    //           child: ListTile(
    //             //leading: const Icon(Icons.list),
    //             leading: CircleAvatar(
    //                 radius: (52),
    //                 backgroundColor: Colors.white,
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(50),
    //                   child: Image(
    //                     //image: NetworkImage((products[index].imageUrl) ?? ""),
    //                     image: NetworkImage((widget
    //                             .productslistViewProduct[index]
    //                             .imageCumpnail) ??
    //                         ""),
    //                     height: 50.0,
    //                     width: 50.0,
    //                   ),
    //                 )),
    //             trailing: Text(
    //               (widget.productslistViewProduct[index].active)
    //                   ? "فعال"
    //                   : "غیر فعال",
    //               style: (products[index].active)
    //                   ? const TextStyle(color: Colors.green, fontSize: 15)
    //                   : const TextStyle(color: Colors.red, fontSize: 15),
    //             ),
    //             title: Text(
    //               widget.productslistViewProduct[index].title,
    //               textAlign: TextAlign.center,
    //             ),
    //             //TODO
    //             onTap: () {
    //               context.loaderOverlay.show();
    //               debugPrint("hhhhh");
    //               Network.getProductDetail(tok,
    //                       widget.productslistViewProduct[index].id.toString())
    //                   .then((value) => {
    //                         context.loaderOverlay.hide(),
    //                         Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                               builder: (context) => const ProductDetails()),
    //                         )
    //                       });
    //             },
    //           ),
    //         );
    //       },
    //     );
    //   },
    //   //future: getProjectDetails(),
    //   //* man mashkok am nesbat be in ghaziye
    //   // TODO
    //   //future: Network.getSearchProductList(tok, 'برد'),
    //   future: widget.f,
    // );
  }
}
