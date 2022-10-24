// import 'package:elec_shop/extentions/search_view.dart';
import 'package:flutter/material.dart';
import 'package:elec_shop/extentions/list_view.dart';
import '../Data/products_data.dart';
import 'package:elec_shop/network/networks.dart';
// import 'package:loader_overlay/loader_overlay.dart';

// //import 'package:elec_shop/Screens/product_detail.dart';


class PageListViewProduct extends StatelessWidget {
  const PageListViewProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListViewProduct(
      productslistViewProduct: products,
      f: Network.getGetProductList(tok),
      //f: Network.getSearchProductList(tok, 'برد'),
    );
  }
}



// class ProductList extends StatefulWidget {
//   const ProductList({super.key});

//   @override
//   State<ProductList> createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//   @override
//   Widget build(BuildContext context) {
//     return LoaderOverlay(
//       overlayColor: Colors.black,
//       overlayOpacity: 0.8,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
            
//             title: const Text("لیست محصولات"),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.search),
//                 onPressed: () {
//                   //debugPrint("search");
//                   showSearch(
//                     context: context,
//                     delegate: MySearchDelegate(),
//                   );
//                 },
//               ),
//             ],
//           ),
//           body: ListViewProduct(
//             productslistViewProduct: products,
//             f: Network.getGetProductList(tok),
//             //f: Network.getSearchProductList(tok, 'برد'),
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.business),
//                 label: 'Business',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.school),
//                 label: 'School',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
