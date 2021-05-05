import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/badge.dart';
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
    final cart = Provider.of<Cart>(context, listen: false);

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
          Consumer<Cart>(
            child: IconButton(
              //este child representa o child que nao será redesenahado, conforme parmChild do builder a seguir
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
            ),
            builder: (ctx, parmCart, parmChild) => Badge(
              value: parmCart.itemCount.toString(),
              cor: Colors.orange,
              child: parmChild,
            ),
          ),
        ],
      ),
      body: ProductGrid(_favoritesOnly),
    );
  }
}
