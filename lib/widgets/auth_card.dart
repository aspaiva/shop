import 'dart:io';

import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard({Key key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthMode _authMode = AuthMode.Signup;
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _onSubmit() {
    setState(() {
      _isLoading = true;
    });

    if (!_formKey.currentState.validate()) {
      setState(() {
        _isLoading = false;
      });
    }

    _formKey.currentState.save();
    // sleep(Duration(seconds: 3));

    if (_authMode == AuthMode.Login) {
      //login
    } else {
      //registra
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchMode() {
    setState(() {
      if (_authMode == AuthMode.Login)
        _authMode = AuthMode.Signup;
      else
        _authMode = AuthMode.Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        height: _authMode == AuthMode.Login ? 310 : 350,
        width: MediaQuery.of(context).size.width * 0.75,
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'eMail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@'))
                    return "Informe um email com @";

                  return null; //no error
                },
                onSaved: (newValue) => _authData['email'] = newValue,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true, //ocultar o texto
                validator: (value) {
                  if (value.length < 3)
                    return "Informe senha válida. (min 3 digitos)";

                  return null; //no error
                },
                onSaved: (newValue) => _authData['password'] = newValue,
              ),
              if (_authMode == AuthMode.Signup)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Senha (validação)'),
                  obscureText: true, //ocultar o texto
                  validator: (value) {
                    if (value != _passwordController.text)
                      return "Senha está diferente da anterior";

                    return null; //no error
                  },
                ),
              SizedBox(height: 20),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () {
                    _onSubmit();
                  },
                  child: Text(
                      _authMode == AuthMode.Login ? 'ENTRAR' : 'CADASTRAR'),
                ),
              TextButton(
                child: Text(
                    'ALTERNAR PARA ${_authMode == AuthMode.Login ? 'CADASTRAR' : 'ENTRAR'}'),
                onPressed: () {
                  _switchMode();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
