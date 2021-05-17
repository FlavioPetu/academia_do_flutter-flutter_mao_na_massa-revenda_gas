import 'dart:convert';

class RevendaModel {
  String tipo;
  String nome;
  String cor;
  double nota;
  String tempoMedio;
  bool melhorPreco;
  double preco;

  RevendaModel({
    this.tipo,
    this.nome,
    this.cor,
    this.nota,
    this.tempoMedio,
    this.melhorPreco,
    this.preco,
  });

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'nome': nome,
      'cor': cor,
      'nota': nota,
      'tempoMedio': tempoMedio,
      'melhorPreco': melhorPreco,
      'preco': preco,
    };
  }

  factory RevendaModel.fromMap(Map<String, dynamic> map) {
    return RevendaModel(
      tipo: map['tipo'],
      nome: map['nome'],
      cor: map['cor'],
      nota: map['nota'],
      tempoMedio: map['tempoMedio'],
      melhorPreco: map['melhorPreco'],
      preco: map['preco'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RevendaModel.fromJson(String source) =>
      RevendaModel.fromMap(json.decode(source));
}
