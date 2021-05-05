import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de compras'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total:'),
                    SizedBox(width: 20),
                    Chip(label: Text(cart.totalAmount.toStringAsFixed(2))),
                    Spacer(),
                    ElevatedButton(
                      child: Text('COMPRAR'),
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false)
                            .addOrder(cart);
                        cart.clear();
                      },
                    ),
                  ]),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, index) {
                return CartItemWidget(cartItem: cartItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
