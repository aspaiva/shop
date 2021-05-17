import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/providers/orders.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({Key key, this.order}) : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false; //cannot be final

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      ListTile(
        title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
        subtitle:
            Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date)),
        trailing: IconButton(
          icon: Icon(Icons.expand_more),
          onPressed: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
        ),
      ),
      if (_expanded)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          height: (widget.order.products.length * 25.0) + 10,
          child: ListView(
            children: widget.order.products.map((product) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.title
                      .substring(0, min(25, product.title.length))),
                  Text(
                      '${product.quantity} x R\$ ${product.price} = ${product.quantity * product.price}'),
                ],
              );
            }).toList(),
          ),
        ),
    ]));
  }
}
