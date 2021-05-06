import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/widgets/product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
//a lista de produtos agora chega via provider, náo mais pela lista estática
    //tem que informar o T de .of(T) pro provider saber de qual provider estamos falando, já que podemos ter vários no app. Se não informar não tem como acessar os dados de produto
    //final List<Product> loadedProducts = Provider.of<Products>(context).items;

    //Outra forma de popular a lista dos dados via providers
    final productsProvider = Provider.of<Products>(context);
    final loadedProducts = showFavoriteOnly
        ? productsProvider.favoriteItems
        : productsProvider.items;

    return GridView.builder(
      itemCount: loadedProducts.length,
      padding: const EdgeInsets.all(10),
      // itemBuilder: (ctx, index) => ChangeNotifierProvider(  //v0: usava create incorretamente, pois em reuso do provider deve-se usar o .value
      //   create: (_) => loadedProducts[index],
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        //conforme documentacao oficial: usar .value(value:) em vez de create: quando for reuso do provider
        value: loadedProducts[index],
        child: ProductGridItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // childAspectRatio: 3 / 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
      ),
    );
  }
}
