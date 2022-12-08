import 'package:shrine/model/product.dart';

class Order {
  String orderID;
  Map<Product, int> products;
  String name;
  DateTime orderDate;
  DateTime deliveryDate;
  String address;
  bool isDelivered;

  Order(
      {required this.deliveryDate,
      required this.orderID,
      required this.products,
      required this.name,
      required this.orderDate,
      required this.address,
      required this.isDelivered});
}
