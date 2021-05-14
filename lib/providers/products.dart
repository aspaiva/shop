import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/providers/product.dart';

//ChangeNotifier é um MIXIN nativo do Flutter para o design pattern OBSERVER
class Products with ChangeNotifier {
  List<Product> _items = myDummyProducts;

  List<Product> get items => [..._items]; //spread operator ...

  List<Product> get favoriteItems {
    return items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> addProduct(Product product) {
    const url =
        'https://flutter-cod3r-95cce-default-rtdb.firebaseio.com/products';

    return post(
      //post = set, include, add
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite,
      }),
    ).then((response) {
      product.id = json.decode(response.body)['name'];
      _items.add(product); //Um evento relevante
      notifyListeners(); //aviso aos subscribers/observers/listeners
    });
    // .catchError((onError) {
    //   print(onError);
    //   throw onError;
    // })
  }

  Future<void> updateProduct(Product produto) {
    if (produto == null || produto.id.isEmpty) return Future<void>(null);
    final index = _items.indexWhere((element) => element.id == produto.id);
    if (index >= 0) {
      _items[index] = produto;
      notifyListeners();
    }
    return Future<void>(null);
  }

  void deleteProduct(String id) {
    if (_items.indexWhere((element) => element.id == id) >= 0) {
      _items.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }
}
