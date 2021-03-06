import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/views/auth_screen.dart';
import 'package:shop/views/cart_screen.dart';
import 'package:shop/views/product_form_screen.dart';
import 'package:shop/views/orders_screen.dart';
import 'package:shop/views/product_detail_screen.dart';
//import 'package:shop/views/products_overview_screen.dart';
import 'package:shop/views/products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()), //new is optional
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
        ChangeNotifierProvider(create: (_) => Auth()),
      ], //create: a new provider, not a reuse
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Lato',
            accentColor: Colors.deepOrange),
        // home: ProductOverviewScreen(),
        routes: {
          AppRoutes.AUTH: (_) => AuthScreen(),
          AppRoutes.HOME: (_) => OrdersScreen(),
          AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailScreen(),
          AppRoutes.CART: (context) => CartScreen(),
          AppRoutes.ORDERS: (_) => OrdersScreen(),
          AppRoutes.CADPROD: (_) => ProductFormScreen(),
          AppRoutes.PRODUCTS: (_) => ProductsScreen(),
        },
      ),
    );
  }
}
