import 'package:flutter/material.dart';

class Dialogs {
  void showErrorDialog(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(msg),
            title: Text('Erro:'),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Fechar'))
            ],
          );
        });
  }
}
