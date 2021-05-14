import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({Key key}) : super(key: key);

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _urlFocus = FocusNode();
  final _urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //fill only if first time here
    if (_formData.isEmpty) {
      //get the argument passed by navigator.of.pushNamed
      final produto = ModalRoute.of(context).settings.arguments as Product;

      _formData['price'] = "0.00"; //default value avoid erros on new product

      //what if is a new product and there is no arguments?
      if (produto != null) {
        _formData['id'] = produto.id;
        _formData['title'] = produto.title;
        _formData['price'] = produto.price;
        _formData['description'] = produto.description;
        _formData['imageUrl'] = produto.imageUrl;

        _urlController.text = produto.imageUrl;
      } else {
        _formData['title'] = "Novo produto ${Random().nextDouble().toString()}";
        _formData['price'] = 123.45;
        _formData['description'] = "Nova description para meu novo produto";
        _urlController.text =
            "https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg";
      }
    }
  }

  void _updateImage() {
    if (_isValidUrl(_urlController.text)) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _urlFocus.addListener(_updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _urlFocus.removeListener(_updateImage);
    _urlFocus.dispose();
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save(); //popula _formData com dados dos controles

    final produto = new Product(
      id: _formData['id'],
      title: _formData['title'],
      description: _formData['description'],
      price: _formData['price'],
      imageUrl: _formData['imageUrl'],
    );

    setState(() {
      _isLoading = true;
    });

    final products = Provider.of<Products>(context, listen: false);
    if (produto.id == null) {
      try {
        await products.addProduct(produto);
        // as proximas linhas só são chamadas se o await acima for bem sucedido
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gravado com sucesso')));
        Navigator.of(context)
            .pop(); //fecha a screen atual e cai na próxima da pilha
      } catch (e) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Ocorreu um error'),
            content: Text(e.toString()),
            actions: [
              ElevatedButton(
                child: Text('Ok'),
                onPressed: () {
                  return Navigator.of(context)
                      .pop(); //Fecha o popup, nao a Screen atual
                },
              )
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      products.updateProduct(produto).then((value) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Alterado com sucesso')));
        Navigator.of(context).pop();
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Erro ao alterar')));
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  bool _isValidUrl(String value) {
    if (value.isEmpty) return false;
    if (!value.contains("http://") && !value.contains('https://')) return false;
    if (!value.endsWith('.jpg') &&
        !value.endsWith('.png') &&
        !value.endsWith('.jpeg') &&
        !value.endsWith('.svg')) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['title'],
                      decoration: InputDecoration(
                        labelText: 'Título do Produto',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        Focus.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (newValue) {
                        print('Salvou Produto: $newValue');
                        _formData['title'] = newValue;
                      },
                      validator: (value) {
                        if (value.isEmpty) return "Informe o título";
                        if (value.length < 5)
                          return "Título deve ter 5 ou mais caracteres";
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Preço',
                      ),
                      initialValue: _formData['price'].toString(),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      onFieldSubmitted: (value) =>
                          Focus.of(context).requestFocus(_descriptionFocus),
                      onSaved: (newValue) {
                        print('salvou Preco: ${newValue.toString()}');
                        _formData['price'] = double.parse(newValue);
                      },
                      validator: (value) {
                        if (double.parse(value) <= 0)
                          return "Preço deve ser maior que zero";

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description'],
                      decoration: InputDecoration(labelText: 'Descrição'),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      focusNode: _descriptionFocus,
                      onFieldSubmitted: (_) =>
                          Focus.of(context).requestFocus(_urlFocus),
                      onSaved: (newValue) =>
                          _formData['description'] = newValue,
                      validator: (value) {
                        if (value.isEmpty)
                          return "Description deve ser preenchida";
                        if (value.length < 15)
                          return "Description deve ser maior que 15 caracteres";
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            // initialValue: _formData['imageUrl'],
                            // initialValue: _urlController.text,
                            decoration:
                                InputDecoration(labelText: 'URL da imagem'),
                            keyboardType: TextInputType.url,
                            focusNode: _urlFocus,
                            controller: _urlController,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (newValue) =>
                                _formData['imageUrl'] = newValue,
                            validator: (value) {
                              if (value.isEmpty)
                                return "informe a url da imagem";
                              if (!value.contains("http://") &&
                                  !value.contains('https://'))
                                return "Informe o protocolo http ou https";
                              if (!value.endsWith('.jpg') &&
                                  !value.endsWith('.png') &&
                                  !value.endsWith('.jpeg') &&
                                  !value.endsWith('.svg'))
                                return "Use uma extensão de imagem jpg, jpeg, png ou svg";
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _urlController.text = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(left: 5, top: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: !_isValidUrl(_urlController.text)
                              ? Text('URL ??')
                              : Image.network(
                                  _urlController.text,
                                  fit: BoxFit.cover,
                                ),
                          alignment: Alignment.center,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
