import 'package:flutter/material.dart';
import 'package:shop/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({Key key, this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
              child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: FittedBox(
              child: Text(cartItem.price.toString()),
            ),
          )),
          title: Text(cartItem.title),
          subtitle: Text('R\$ ${cartItem.quantity * cartItem.price}'),
          trailing: Text('${cartItem.quantity}x'),
        ),
      ),
    );
  }
}
