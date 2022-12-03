import '../model/product.dart';

List<Product> products = [];

List<Product> cartItems = [];

List<Product> favItems = [];

List<Product> search(query) {
  List<Product> res = [];
  for (Product p in products.where((element) => element.title == query)) {
    res.add(p);
  }
  return res;
}
