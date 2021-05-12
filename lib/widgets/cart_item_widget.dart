import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({Key key, this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 50,
        ),
        padding: const EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
      ),
      child: Card(
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
      ),
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false)
            .removeCartItem(cartItem.productId);
      },
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Exclusão do item'),
            content: Text('Confirma exclusão do item?'),
            actions: [
              ElevatedButton(
                child: Text('Não'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              ElevatedButton(
                child: Text('Sim'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
