import 'package:flutter/material.dart';
import 'package:shop/widgets/product_grid.dart';

//enum tem que estar fora da classe
enum FilterOptions {
  FavoritesOnly,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  // const ProductOverviewScreen({Key key}) : super(key: key);
  //final List<Product> loadedProducts = myDummyProducts;

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _favoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha loja'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Favoritos'),
                value: FilterOptions.FavoritesOnly,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              )
            ],
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.FavoritesOnly)
                  _favoritesOnly = true;
                else
                  _favoritesOnly = false;
              });
            },
          ),
        ],
      ),
      body: ProductGrid(_favoritesOnly),
    );
  }
}
