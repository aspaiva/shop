import 'package:flutter/material.dart';
import 'package:shop/widgets/product_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  // const ProductOverviewScreen({Key key}) : super(key: key);
  //final List<Product> loadedProducts = myDummyProducts;

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
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: 1,
              )
            ],
            onSelected: (value) {
              print(value);
            },
          ),
        ],
      ),
      body: ProductGrid(),
    );
  }
}
