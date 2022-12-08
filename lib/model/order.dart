import 'package:shrine/model/product.dart';

class Order {
  double totalOrderCost;
  String orderID;
  Map<Product, int> productsAndCount;
  String buyer;
  DateTime orderDate;
  DateTime deliveryDate;
  String deliveryAddress;
  String orderStatus;
  String cardUsed;

  Order({
    required this.cardUsed,
    required this.totalOrderCost,
    required this.deliveryDate,
    required this.orderID,
    required this.productsAndCount,
    required this.buyer,
    required this.orderDate,
    required this.deliveryAddress,
    required this.orderStatus,
  });
}
