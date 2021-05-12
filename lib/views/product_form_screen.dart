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

  void _saveForm() {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    Provider.of<Products>(context, listen: false).addProduct(Product(
      id: Random().nextDouble().toString(),
      title: _formData['title'],
      description: _formData['description'],
      price: _formData['price'],
      imageUrl: _formData['imageUrl'],
    ));

    print('Saving...');
    print(_formData);
    Navigator.of(context).pop();
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
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Produto',
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
                initialValue: "0.00",
                keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                decoration: InputDecoration(labelText: 'Descrição'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocus,
                onFieldSubmitted: (_) =>
                    Focus.of(context).requestFocus(_urlFocus),
                onSaved: (newValue) => _formData['description'] = newValue,
                validator: (value) {
                  if (value.isEmpty) return "Description deve ser preenchida";
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
                      decoration: InputDecoration(labelText: 'URL da imagem'),
                      keyboardType: TextInputType.url,
                      focusNode: _urlFocus,
                      controller: _urlController,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (newValue) => _formData['imageUrl'] = newValue,
                      validator: (value) {
                        if (value.isEmpty) return "informe a url da imagem";
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
                        : FittedBox(
                            child: Image.network(
                              _urlController.text,
                              fit: BoxFit.cover,
                            ),
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
