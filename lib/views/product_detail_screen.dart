import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: [
          Image.network(product.imageUrl),
          SizedBox(height: 10),
          Text(
            'R\$ ${product.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                  '${product.description} \n\nbla bla bal bla bla bla bal safaf asdfasf asf asf saf asf asf as fas fas f sdf asfasf asdf asf safasfsa fasf asfasdfasf asfas fasdfasf asfas fsaf saf sfsf safsafsafsa fasf asf as')),
        ],
      ),
    );
  }
}
