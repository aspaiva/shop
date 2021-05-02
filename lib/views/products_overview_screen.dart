import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductOverviewScreen extends StatelessWidget {
  // const ProductOverviewScreen({Key key}) : super(key: key);
  final List<Product> loadedProducts = myDummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha loja'),
      ),
      body: GridView.builder(
        itemCount: myDummyProducts.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (ctx, index) {
          return Text(loadedProducts[index].title);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
