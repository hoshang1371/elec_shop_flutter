class ProductListData {
  const ProductListData({
    required this.id,
    required this.code,
    required this.title,
    required this.place,
    required this.number,
    this.brand,
    required this.description,
    required this.smallDescription,
    required this.price,
    this.priceOff,
    this.imageUrl,
    this.imageCumpnail,
    required this.active,
    required this.visitCount,
    required this.vige,
    required this.categories,
  });
  final num id;
  final String code;
  final String title;
  final String place;
  final num number;
  final String? brand;
  final String description;
  final String smallDescription;
  final String price;
  final String? priceOff;
  final String? imageUrl;
  final String? imageCumpnail;
  final bool active;
  final num visitCount;
  final bool vige;
  final List categories;
}

List<ProductListData> products = <ProductListData>[];
List<ProductListData> searchProducts = <ProductListData>[];

class ProductDetailData {
  // const ProductDetailData({
  //   required this.id,
  //   required this.code,
  //   required this.title,
  //   required this.place,
  //   required this.number,
  //   this.brand,
  //   required this.description,
  //   required this.smallDescription,
  //   required this.price,
  //   this.priceOff,
  //   this.imageUrl,
  //   this.imageCumpnail,
  //   required this.active,
  //   required this.visitCount,
  //   required this.vige,
  //   required this.categories,
  // });
  //static var emp_dept;
  static late num id;
  static late String code;
  static late String title;
  static late String place;
  static late num number;
  static late String? brand;
  static late String description;
  static late String smallDescription;
  static late String price;
  static late String priceOff;
  static late String? imageUrl;
  static late String? imageCumpnail;
  static late bool active;
  static late num visitCount;
  static late bool vige;
  static late List categories;

  static void getAll(Map detailMap) {
    ProductDetailData.id = detailMap["id"];
    ProductDetailData.code = detailMap["code"];
    ProductDetailData.title = detailMap["title".toString()];
    ProductDetailData.place = detailMap["place"].toString();
    ProductDetailData.number = num.parse(detailMap["number"].toString());
    ProductDetailData.description = detailMap["description"].toString();
    ProductDetailData.smallDescription =
        detailMap["smallDescription"].toString();
    ProductDetailData.price = detailMap["price"].toString();
    ProductDetailData.priceOff = detailMap["priceOff"].toString();
    ProductDetailData.imageUrl = detailMap["image"];
    ProductDetailData.imageCumpnail = detailMap["image_tumpnail"];
    ProductDetailData.active = detailMap["active"];
    ProductDetailData.visitCount = detailMap["visit_count"];
    ProductDetailData.vige = detailMap["vige"];
    ProductDetailData.categories = detailMap["categories"];
  }
}
