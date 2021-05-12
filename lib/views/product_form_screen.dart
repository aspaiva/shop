import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  void _updateImage() {
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de produtos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
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
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Preço',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                onFieldSubmitted: (value) =>
                    Focus.of(context).requestFocus(_descriptionFocus),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocus,
                onFieldSubmitted: (_) =>
                    Focus.of(context).requestFocus(_urlFocus),
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
                    child: _urlController.text.isEmpty
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
