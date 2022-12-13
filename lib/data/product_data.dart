import 'package:shrine/model/review.dart';

import '../model/order.dart';
import '../model/product.dart';

List<Product> products = [];

Map<Product, int> cartItems = {};

List<Product> favItems = [];

List<Order> orders = [];

List<Review> reviews = [];

List<Product> prevOrder = [];

double subTotal = 0;
double tax = 0;
double shipping = 0;
double total = 0;
