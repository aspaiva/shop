import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};
  Map<String, CartItem> get items {
    return {..._cartItems};
  }

  int get itemCount {
    return _cartItems.length;
  }

  //double totalAmount() {  //method must have ()
  //getters do not need ()
  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((key, itemCart) {
      total += itemCart.price * itemCart.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
          productId: product.id,
        ),
      );
    } else
      _cartItems.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random()
              .nextDouble()
              .toString(), //este é o id do carrinho, não do produto
          title: product.title,
          quantity: 1,
          price: product.price,
          productId: product.id,
        ),
      );

    notifyListeners();
  }

  void removeCartItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }
}

class CartItem {
  String id;
  String productId;
  String title;
  int quantity;
  double price;

  CartItem({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}
