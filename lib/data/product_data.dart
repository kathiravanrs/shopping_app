import '../model/product.dart';

List<Product> products = [];

Map<Product, int> cartItems = {};

List<Product> favItems = [];

double subTotal = 0;
double tax = 0;
double shipping = 0;
double total = 0;

List<Product> search(query) {
  List<Product> res = [];
  for (Product p in products.where((element) => element.title == query)) {
    res.add(p);
  }
  return res;
}
