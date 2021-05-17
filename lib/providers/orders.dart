import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/utils/globals.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  final _baseUrl = Globals.baseUrl;
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> loadOrders() async {
    final response = await http.get('$_baseUrl/orders.json');
    Map<String, dynamic> dados = json.decode(response.body);

    _orders.clear();
    // print(dados);
    if (dados != null) {
      dados.forEach((orderId, orderData) async {
        _orders.add(
          Order(
            id: orderId,
            total: orderData['total'],
            date: DateTime.parse(orderData['date']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (cartItem) => CartItem(
                    id: cartItem['id'],
                    productId: cartItem['productId'],
                    title: cartItem['title'],
                    quantity: cartItem['quantity'],
                    price: cartItem['price'],
                  ),
                )
                .toList(),
          ),
        );
        // await Future.delayed(Duration(seconds: 2));
        notifyListeners();
      });
      _orders = _orders.reversed.toList();
      return Future.value();
    }
  }

  Future<void> addOrder(Cart carrinho) async {
    final data = DateTime.now(); //mesma data para ambos os locais

    final response = await http.post('$_baseUrl/orders.json',
        body: json.encode({
          'total': carrinho.totalAmount,
          'date': data.toIso8601String(),
          'products': carrinho.items.values
              .map((item) => {
                    'id': item.id,
                    'productId': item.productId,
                    'title': item.title,
                    'quantity': item.quantity,
                    'price': item.price,
                  })
              .toList()
        }));

    _orders.insert(
      0, //posicao da fila: inicio
      Order(
        id: json.decode(response.body)['name'],
        total: carrinho.totalAmount,
        products: carrinho.items.values.toList(),
        date: data,
      ),
    );

    notifyListeners();
  }
}

class Order {
  final String id;
  final double total;
  final DateTime date;
  final List<CartItem> products;

  Order({
    @required this.id,
    @required this.total,
    @required this.date,
    this.products,
  });
}
