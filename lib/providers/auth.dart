import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop/utils/globals.dart';

//usando o mixin ChangeNotifier para criar o PROVIDER
class Auth with ChangeNotifier {
//signUp: 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]';
//signIn: 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY'

  Future<void> _authenticate(String email, String password, String mode) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$mode?key=${Globals.apiKey}';
    final response = await post(url,
        body: json.encode({
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }));

    print(json.decode(response.body)['localId']);
    print(json.decode(response.body));
    return Future.value();
  }

  Future<void> cadastrarUsuario(String email, String password) async {
    _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    _authenticate(email, password, "signInWithPassword");
  }
}
