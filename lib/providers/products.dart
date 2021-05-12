import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/providers/product.dart';

//ChangeNotifier é um MIXIN nativo do Flutter para o design pattern OBSERVER
class Products with ChangeNotifier {
  List<Product> _items = myDummyProducts;

  List<Product> get items => [..._items]; //spread operator ...

  List<Product> get favoriteItems {
    return items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product product) {
    product.id = Random().nextDouble().toString();
    _items.add(product); //Um evento relevante
    notifyListeners(); //aviso aos subscribers/observers/listeners
  }

  void updateProduct(Product produto) {
    if (produto == null || produto.id.isEmpty) return;

    final index = _items.indexWhere((element) => element.id == produto.id);

    if (index >= 0) {
      _items[index] = produto;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    if (_items.indexWhere((element) => element.id == id) >= 0) {
      _items.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }
}
