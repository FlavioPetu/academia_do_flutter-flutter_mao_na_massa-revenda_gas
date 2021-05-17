import 'package:desafio_mao_na_massa/app/model/revenda_model.dart';
import 'package:desafio_mao_na_massa/app/pages/detalhe_page.dart';
import 'package:desafio_mao_na_massa/app/pages/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        DetalhePage.routerName: (_) {
          var revenda = ModalRoute.of(_).settings.arguments as RevendaModel;
          return DetalhePage(
            revenda: revenda,
          );
        }
      },
    );
  }
}
