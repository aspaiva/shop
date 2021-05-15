import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../utils/globals.dart';

//Product passa a ser também um provider com recursos de notifier (um subject)
class Product with ChangeNotifier {
  String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite; //Evento: sempre que o estado do favorito mudar...
    notifyListeners(); //avisar aos interessados (observers)
  }

  Future<void> toggleFavorite() async {
    _toggleFavorite();

    try {
      final response = await patch(
        '${Globals.baseUrl}/${this.id}.json',
        body: json.encode(
          {'isFavorite': isFavorite},
        ),
      );

      if (response.statusCode != 200) {
        //rollback erro http
        _toggleFavorite();
      }
    } catch (error) {
      //rollback qq erro
      _toggleFavorite();
    }
  }
}
