import '../model/product.dart';

List<Product> products = [];

List<Product> cartItems = [
  Product(
      id: "p1",
      title: "Red Shirt",
      description: "A red shirt - it is pretty red!",
      price: 29.99,
      imageUrl: "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg"),
  Product(
      id: "p1",
      title: "Red Shirt",
      description: "A red shirt - it is pretty red!",
      price: 29.99,
      imageUrl: "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg"),
  Product(
      id: "p1",
      title: "Red Shirt",
      description: "A red shirt - it is pretty red!",
      price: 29.99,
      imageUrl: "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg"),
  Product(
      id: "p1",
      title: "Red Shirt",
      description: "A red shirt - it is pretty red!",
      price: 29.99,
      imageUrl: "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg"),
  Product(
      id: "p1",
      title: "Red Shirt",
      description: "A red shirt - it is pretty red!",
      price: 29.99,
      imageUrl: "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg"),
  Product(
      id: "p1",
      title: "Red Shirt",
      description: "A red shirt - it is pretty red!",
      price: 29.99,
      imageUrl: "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg"),
];

List<Product> search(query) {
  List<Product> res = [];
  for (Product p in products.where((element) => element.title == query)) {
    res.add(p);
  }
  return res;
}
