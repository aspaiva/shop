import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Pedidos do usuário'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Loja'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.insert_emoticon),
            title: Text('Cadastro de Produtos'),
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.CADPROD),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Produtos'),
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.PRODUCTS),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.close),
            title: Text('Fechar'),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
