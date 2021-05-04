import 'package:flutter/foundation.dart';

//Product passa a ser também um provider com recursos de notifier (um subject)
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite; //Evento: sempre que o estado do favorito mudar...
    notifyListeners(); //avisar aos interessados (observers)
  }
}
