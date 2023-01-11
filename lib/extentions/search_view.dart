import 'package:flutter/material.dart';

import 'package:elec_shop/network/networks.dart';

import 'package:elec_shop/extentions/list_view.dart';

import '../Data/products_data.dart';

//import 'package:loader_overlay/loader_overlay.dart';

//State<ListViewProduct>
class MySearchDelegate extends SearchDelegate {
//class MySearchDelegate extends SearchDelegate {
  // List<ProductListData> searchResults = products;
  //List<ProductListData> searchResults = <ProductListData>[];

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
    );
    return null;
    //throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
    return null; //throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    //return const listViewProduct();
    debugPrint("search");
    // context.loaderOverlay.show();
    searchProducts.clear();
    return ListViewProduct(
      productslistViewProduct: searchProducts,
      f: Network.getSearchProductList(tok, query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // List<ProductListData> suggestions = searchResults.where((searchResult) {
    //   final result = searchResult.title.toLowerCase();
    //   final input = query.toLowerCase();

    //   return result.contains(input);
    // }).toList();


    searchProducts.clear();
    return ListViewProduct(
      productslistViewProduct: searchProducts,
      f: Network.getSearchProductList(tok, query),
    );
  }
}
