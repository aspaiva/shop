import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';

class ProductItem extends StatelessWidget {
  final Product produto;
  const ProductItem({Key key, this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(produto.imageUrl),
        radius: 25,
      ),
      title: Text(produto.title),
      subtitle: Text(produto.description),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ]),
      ),
    );
  }
}
