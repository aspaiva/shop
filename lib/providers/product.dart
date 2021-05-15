import 'dart:convert';

import 'package:flutter/foundation.dart';
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

  void toggleFavorite() {
    isFavorite = !isFavorite; //Evento: sempre que o estado do favorito mudar...

    patch(
      '${Globals.baseUrl}/${this.id}.json',
      body: json.encode(
        {'isFavorite': isFavorite},
      ),
    );

    notifyListeners(); //avisar aos interessados (observers)
  }
}
