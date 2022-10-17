import 'package:flutter/material.dart';
import '../Data/products_data.dart';
import 'package:elec_shop/network/networks.dart';

import 'package:elec_shop/Screens/product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("لیست محصولات"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                //debugPrint("search");
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              },
            ),
          ],
        ),
        body: ListViewProduct(productslistViewProduct: products),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewProduct extends StatefulWidget {
  ListViewProduct({
    Key? key,
    required this.productslistViewProduct,
  }) : super(key: key);

  List<ProductListData> productslistViewProduct = <ProductListData>[];

  @override
  State<ListViewProduct> createState() => _ListViewProductState();
}

class _ListViewProductState extends State<ListViewProduct> {
  //final int g;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return ListView.builder(
          itemCount: widget.productslistViewProduct.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              //leading: const Icon(Icons.list),
              leading: CircleAvatar(
                  radius: (52),
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      //image: NetworkImage((products[index].imageUrl) ?? ""),
                      image: NetworkImage((widget
                              .productslistViewProduct[index].imageCumpnail) ??
                          ""),
                      height: 50.0,
                      width: 50.0,
                    ),
                  )),
              trailing: Text(
                (widget.productslistViewProduct[index].active)
                    ? "فعال"
                    : "غیر فعال",
                style: (products[index].active)
                    ? const TextStyle(color: Colors.green, fontSize: 15)
                    : const TextStyle(color: Colors.red, fontSize: 15),
              ),
              title: Text(
                widget.productslistViewProduct[index].title,
                textAlign: TextAlign.center,
              ),
              //TODO
              onTap: () {
                Network.getProductDetail(tok,
                        widget.productslistViewProduct[index].id.toString())
                    .then((value) => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProductDetails()),
                          )
                        });
                debugPrint(products[index].id.toString());
              },
            );
          },
        );
      },
      //future: getProjectDetails(),
      //* man mashkok am nesbat be in ghaziye
      // TODO
      future: Network.getSearchProductList(tok, 'برد'),
    );
  }
}

//State<ListViewProduct>
class MySearchDelegate extends SearchDelegate {
//class MySearchDelegate extends SearchDelegate {
  List<ProductListData> searchResults = products;
  //List<ProductListData> searchResults = <ProductListData>[];
  bool _isItemSelected = true;

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
    searchProducts.clear();
    // Network.getSearchProductList(tok, 'برد').then((value1) => {

    //     });

    // List<ProductListData> respon = searchResults.where((searchResult) {
    //   final result = searchResult.title.toLowerCase();
    //   final input = query.toLowerCase();

    //   return result.contains(input);
    // }).toList();

    return ListViewProduct(productslistViewProduct: searchProducts);
    //return ListViewProduct(productslistViewProduct: searchProducts);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductListData> suggestions = searchResults.where((searchResult) {
      final result = searchResult.title.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListViewProduct(productslistViewProduct: suggestions);
  }

}
