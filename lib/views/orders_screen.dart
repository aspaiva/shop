import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/order_widget.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final orders = Provider.of<Orders>(context).orders;

    // Future<void> refreshOrders() async {
    //   return Provider.of<Orders>(context, listen: false).loadOrders();
    // }

    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).loadOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Ocorreu um erro ao buscar dados: \n${snapshot.error.toString()}',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ),
                )),
              );
            } else {
              return Consumer<Orders>(builder: (ctx, orders, child) {
                return RefreshIndicator(
                    onRefresh: () => Provider.of<Orders>(context, listen: false)
                        .loadOrders(),
                    child: orders.orders.length > 0
                        ? ListView.builder(
                            itemCount: orders.orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              return OrderWidget(
                                  order: orders.orders.elementAt(index));
                            },
                          )
                        : Center(
                            child: Text('Sem pedidos na lista',
                                style: TextStyle(fontSize: 25))));
              });
            }
          }),
    );
  }
}
