class DateTime {
  final String date;
  final String time;

  DateTime(this.date, this.time);
}

class OrderListData {
  const OrderListData({
    required this.id,
    required this.owner,
    required this.isPaid,
    required this.jPaymentDate,
    required this.paymentDate,
  });
  final num id;
  final num owner;
  final bool isPaid;
  final String jPaymentDate;
  final String paymentDate;

  static String splitPlus(String date) {
    String x = date.split("+")[0];
    if (x.contains('.')) {
      x = x.split(".")[0];
    }
    return x;
  }

  static DateTime spliteSpace(String date) {
    String x = splitPlus(date);
    return DateTime(x.split(" ")[0], x.split(" ")[1]);
  }
}

List<OrderListData> order = <OrderListData>[];

class OrderList {
  OrderList({
    required this.idOrder,
    required this.orderDetailCountPrice,
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
    this.imageTumpnail,
    required this.active,
    required this.visitCount,
    required this.vige,
    // required this.categories,
  });
  final num idOrder;
  final num orderDetailCountPrice;
  final num id;
  final String code;
  final String title;
  final String place;
  // final num number;
  num number;
  final String? brand;
  final String description;
  final String smallDescription;
  final String price;
  final String? priceOff;
  final String? imageUrl;
  final String? imageTumpnail;
  final bool active;
  final num visitCount;
  final bool vige;
  // final List categories;
  static num allTotalPrice =0;
}

List<OrderList> ordrlist = <OrderList>[];
