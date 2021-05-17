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
                    OrderButton(cart: cart),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: _isLoading ? CircularProgressIndicator() : Text('COMPRAR'),
      onPressed: widget.cart.totalAmount == 0
          ? null //sem produto no carrinho, botao sem retorno
          : () async {
              setState(() {
                _isLoading = true;
              });

              await Provider.of<Orders>(context, listen: false)
                  .addOrder(widget.cart)
                  .then((value) => ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Pedido gravado'))))
                  .onError((error, stackTrace) => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            content: Text(error.toString()),
                            actions: [
                              ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('Fechar'))
                            ],
                          )));
              widget.cart.clear();
              setState(() {
                _isLoading = false;
              });
            },
    );
  }
}
