import 'package:shrine/model/product.dart';

class Order {
  double totalOrderCost;
  String orderID;
  Map<Product, int> productsAndCount;
  DateTime orderDate;
  DateTime deliveryDate;
  String deliveryAddressID;
  String orderStatus;
  String cardUsed;

  Order({
    required this.cardUsed,
    required this.totalOrderCost,
    required this.deliveryDate,
    required this.orderID,
    required this.productsAndCount,
    required this.orderDate,
    required this.deliveryAddressID,
    required this.orderStatus,
  });
}
