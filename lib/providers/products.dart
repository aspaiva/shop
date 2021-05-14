import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop/providers/product.dart';

//ChangeNotifier é um MIXIN nativo do Flutter para o design pattern OBSERVER
class Products with ChangeNotifier {
  final String _baseUrl =
      'https://flutter-cod3r-95cce-default-rtdb.firebaseio.com/products';
  List<Product> _items = [];

  Future<void> loadProductsFromCloud() async {
    final response = await get('$_baseUrl.json');
    Map<String, dynamic> dados = json.decode(response.body);

    _items.clear();
    if (dados != null)
      dados.forEach((key, produto) {
        _items.add(
          Product(
            id: key,
            title: produto['title'],
            description: produto['description'],
            price: produto['price'],
            imageUrl: produto['imageUrl'],
            isFavorite: produto['isFavorite'],
          ),
        );
        notifyListeners();
      });
    return Future.value();
  }

  List<Product> get items => [..._items]; //spread operator ...

  List<Product> get favoriteItems {
    return items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> addProduct(Product product) async {
    final response = await post(
      //post = set, include, add
      '$_baseUrl.json',
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite,
      }),
    );

    product.id = json.decode(response.body)['name'];
    _items.add(product); //Um evento relevante
    notifyListeners(); //aviso aos subscribers/observers/listeners
  }

  Future<void> updateProduct(Product produto) async {
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
