import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {
  //com adição do provider o parametro náo é mais usado para receber o produto no construtor
  // final Product product;
  // const ProductItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //listen: false => indica que o listener nao deve ser avisado dos eventos
    //muito util quando nao temos propriedades que sao afetadas por mudanças de outros atributos, evitando redraw de widget desnece//
    // final Product product = Provider.of<Product>(context);
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            //Consumer widget permite receber notificacao somente para este ponto da widget tree, sendo cirurgico quanto ao ponto de redraw
            //atenção ao terceiro param child, aqui descartado com underline, mas que pode ser a exceção de redraw de um consumer
            builder: (ctx, innerProduct, _) => IconButton(
              icon: Icon(
                innerProduct.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => product.toggleFavorite(),
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Produto adicionado!'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'DESFAZER',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ));
              cart.addItem(product);
            },
          ),
        ),
      ),
    );
  }
}
