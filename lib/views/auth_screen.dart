import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/widgets/auth_card.dart';
// import 'package:shop/widgets/auth_card.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 0.5),
                  Color.fromRGBO(255, 188, 117, 0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 70),
                  transform: Matrix4.rotationZ(-8 * pi / 180)
                    ..translate(-10.0), //aula 290: cascade op ..
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrange.shade900,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black87,
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: Text(
                    'Minha loja',
                    style: TextStyle(
                        fontSize: 45,
                        fontFamily: 'Anton',
                        color:
                            Theme.of(context).accentTextTheme.headline6.color),
                  ),
                ),
                AuthCard(),
              ],
            ),
          ),
          // AuthCard()
        ],
      ),
    );
  }
}
