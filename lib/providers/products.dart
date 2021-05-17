import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/utils/globals.dart';

//ChangeNotifier é um MIXIN nativo do Flutter para o design pattern OBSERVER
class Products with ChangeNotifier {
  final String _baseUrlProducts = '${Globals.baseUrl}/products';

  List<Product> _items = [];

  Future<void> loadProductsFromCloud() async {
    final response = await get('$_baseUrlProducts.json');
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
      '$_baseUrlProducts.json',
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
      await patch(
        '$_baseUrlProducts/${produto.id}.json',
        body: json.encode({
          'title': produto.title,
          'description': produto.description,
          'price': produto.price,
          'imageUrl': produto
              .imageUrl, //nao pegou isFavorite pq nao sofre alteracao no form
        }),
      );
      _items[index] = produto;
      notifyListeners();
    }
    return Future<void>(null);
  }

  Future<void> deleteProduct(String id) async {
    if (_items.indexWhere((element) => element.id == id) >= 0) {
      final response = await delete('$_baseUrlProducts/$id');

      if (response.statusCode == 200) {
        _items.removeWhere((element) => element.id == id);
        notifyListeners();
      } else {
        throw 'Erro ao deletar na nuvem: ${response.body} com statusCode=${response.statusCode}';
      }
    }
  }
}
