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
