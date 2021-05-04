import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

//ChangeNotifier é um MIXIN nativo do Flutter para o design pattern OBSERVER
class Products with ChangeNotifier {
  List<Product> _items = myDummyProducts;

  List<Product> get items => [..._items]; //spread operator ...

  List<Product> get favoriteItems {
    return items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product product) {
    _items.add(product); //Um evento relevante
    notifyListeners(); //aviso aos subscribers/observers/listeners
  }
}
