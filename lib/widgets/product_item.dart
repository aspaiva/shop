import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product produto;
  const ProductItem({Key key, this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(produto.imageUrl),
        radius: 25,
      ),
      title: Text(produto.title),
      subtitle: Text(produto.description),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.CADPROD,
                arguments: produto,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Excluir'),
                  content: Text('Tem certeza?'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(
                            false); //false caso queira usar o then do future
                      },
                      child: Text('Não'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<Products>(context, listen: false)
                            .deleteProduct(produto.id);
                        Navigator.of(context)
                            .pop(true); //true caso queira usar o then do future
                      },
                      child: Text('Sim, estou certo disso'),
                    )
                  ],
                ),
              ).then((value) {
                if (value) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Produto excluído'),
                    duration: Duration(seconds: 2),
                  ));

                  //pode testar se ainda tem produto e se a lista estiver vazia pode navegar para outra tela
                }
              });
            },
          ),
        ]),
      ),
    );
  }
}
