import 'package:shrine/model/product.dart';

class Order {
  List<Product> products;
  String name;
  DateTime dateTime;
  String address;

  Order(this.products, this.name, this.dateTime, this.address);
}
