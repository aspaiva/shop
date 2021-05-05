import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/providers/cart.dart';

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> products, double total) {
    _orders.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: total,
        products: products,
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    @required this.id,
    @required this.total,
    @required this.products,
    @required this.date,
  });
}
