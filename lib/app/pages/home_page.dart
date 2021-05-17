import 'dart:ui';

import 'package:desafio_mao_na_massa/app/model/revenda_model.dart';
import 'package:desafio_mao_na_massa/app/pages/detalhe_page.dart';
import 'package:desafio_mao_na_massa/app/repositories/revendas_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Escolha uma Revenda'),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.swap_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Melhor Avaliação",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Checkbox(value: false, onChanged: null)
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mais Rápido",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Checkbox(value: false, onChanged: null)
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mais barato",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Checkbox(value: false, onChanged: null)
                  ],
                ),
              ),
            ],
          ),
          PopupMenuButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '?',
                style: TextStyle(fontSize: 25),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text(
                  "Suporte",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  "Termos de serviço",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Botijões de 13kg em:',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      Text(
                        'Av. Paulista, 1001',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Paulista, São Paulo, SP',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.blue,
                      size: 30,
                    ),
                    Text(
                      'Mudar',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: FutureBuilder<List<RevendaModel>>(
              future: RevendasRepository().buscarTodasRevendas(),
              builder: (_, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Container();
                    break;
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                    break;
                  case ConnectionState.active:
                  case ConnectionState.done:
                    var data = snapshot.data;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_, index) {
                        return _buildRevenda(data[index]);
                      },
                    );
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenda(RevendaModel revenda) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, DetalhePage.routerName,
          arguments: revenda),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        height: 120,
        child: Row(
          children: [
            Container(
              width: 40,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(int.parse('FF${revenda.cor}', radix: 16)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: RotatedBox(
                quarterTurns: -1,
                child: Center(
                  child: Text(
                    revenda.tipo,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(revenda.nome)),
                        Visibility(
                          visible: revenda.melhorPreco,
                          child: _buildTag(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nota',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  revenda.nota.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Tempo Médio',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 10),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: revenda.tempoMedio,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    TextSpan(
                                      text: 'min',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Preço',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'R\$ ${revenda.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.label,
            color: Colors.white,
            size: 18,
          ),
          Text(
            'Melhor preço',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
