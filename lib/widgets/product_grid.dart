import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//a lista de produtos agora chega via provider, náo mais pela lista estática
    //tem que informar o T de .of(T) pro provider saber de qual provider estamos falando, já que podemos ter vários no app. Se não informar não tem como acessar os dados de produto
    final List<Product> loadedProducts = Provider.of<Products>(context).items;

    //Outra forma de popular a lista dos dados via providers
    // final productsProvider = Provider.of<Products>(context);
    // final loadedProducts = productsProvider.items;

    return GridView.builder(
      itemCount: loadedProducts.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, index) {
        // return Text(loadedProducts[index].title);
        return ProductItem(
          product: loadedProducts.elementAt(index),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
