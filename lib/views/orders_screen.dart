import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/order_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoading = true;
    });

    Provider.of<Orders>(context, listen: false).loadOrders().then((value) => {
          setState(() {
            _isLoading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;

    Future<void> refreshOrders() async {
      return Provider.of<Orders>(context, listen: false).loadOrders();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : orders.length > 0
              ? RefreshIndicator(
                  onRefresh: () => refreshOrders(),
                  child: Center(
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        return OrderWidget(
                          order: orders.elementAt(index),
                        );
                      },
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    'Nenhum pedido carregado',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
    );
  }
}
