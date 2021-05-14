import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/product_item.dart';

/*
  Listar os produtos em forma de coluna/pilha
*/

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  Future<void> refreshProducts(BuildContext context) async {
    return Provider.of<Products>(context, listen: false)
        .loadProductsFromCloud();
  }

  @override
  Widget build(BuildContext context) {
    var produtos = Provider.of<Products>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.CADPROD);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (ctx, index) {
                return Column(children: [
                  ProductItem(
                    produto: produtos.elementAt(index),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                ]);
              }),
        ),
      ),
    );
  }
}
