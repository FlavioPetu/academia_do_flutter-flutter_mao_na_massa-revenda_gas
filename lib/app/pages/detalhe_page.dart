import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:desafio_mao_na_massa/app/model/revenda_model.dart';

class DetalhePage extends StatefulWidget {
  static String routerName = '/detalhe';
  final RevendaModel revenda;

  const DetalhePage({
    Key key,
    @required this.revenda,
  }) : super(key: key);

  @override
  _DetalhePageState createState() => _DetalhePageState(revenda: revenda);
}

class _DetalhePageState extends State<DetalhePage> {
  final RevendaModel revenda;
  int totalProduto = 1;
  double totalValor;

  _DetalhePageState({@required this.revenda}) : totalValor = revenda.preco;

  var appBar = AppBar(
    title: Text('Selecionar Produtos'),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '?',
          style: TextStyle(fontSize: 30),
        ),
      ),
    ],
  );

  void adicionaProduto() {
    setState(() {
      totalProduto++;
      totalValor = totalProduto * revenda.preco;
    });
  }

  void removeProduto() {
    setState(() {
      if (totalProduto > 1) {
        totalProduto--;
        totalValor = totalProduto * revenda.preco;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mQ = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: appBar,
      body: Container(
        width: mQ.size.width,
        height: mQ.size.height - appBar.preferredSize.height - mQ.padding.top,
        child: Column(
          children: [
            _buildTitle(),
            SizedBox(height: 2),
            _buildSubTitle(),
            _buildCard(),
            Expanded(child: SizedBox()),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200],
                      blurRadius: 1,
                      spreadRadius: 8,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text('Comprar'),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Divider(color: Colors.grey),
                SizedBox(height: 20),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text('Pagamento'),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Divider(color: Colors.grey),
                SizedBox(height: 20),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text('Confirmação'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubTitle() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                // color: Colors.black,
                color: Color(int.parse('FF${revenda.cor}', radix: 16)),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  totalProduto.toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text('${revenda.nome} - Botijão de 13kg'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: RichText(
              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                TextSpan(
                  text: 'R\$ ',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                TextSpan(
                  text: totalValor.toStringAsFixed(2).replaceAll('.', ','),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      margin: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.home,
                size: 40,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(revenda.tipo, style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(revenda.nota.toString()),
                        Icon(Icons.star, color: Colors.yellow, size: 15),
                        Text('${revenda.tempoMedio} min'),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      revenda.tipo,
                      style: TextStyle(color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      color: Color(int.parse('FF${revenda.cor}', radix: 16)),
                    ),
                  )
                ],
              ),
            ],
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Botijão de 13kg'),
                    SizedBox(height: 5),
                    Text(revenda.tipo),
                    SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'R\$ ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            TextSpan(
                              text: revenda.preco
                                  .toStringAsFixed(2)
                                  .replaceAll('.', ','),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ]),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                          onTap: () {
                            removeProduto();
                          },
                          child: Icon(Icons.remove)),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://infoeds.com.br/wp-content/uploads/2017/11/prod_icon-gas.png'),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(4),
                          child: Text(
                            totalProduto.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.orange),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                          onTap: () {
                            adicionaProduto();
                          },
                          child: Icon(Icons.add)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: RaisedButton(
        onPressed: () {},
        textColor: Colors.white,
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: 250,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blue[300],
              Colors.blue[700],
            ]),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              'IR PARA O PAGAMENTO',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
