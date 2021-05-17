import 'dart:convert';

import 'package:desafio_mao_na_massa/app/model/revenda_model.dart';
import 'package:flutter/services.dart';

class RevendasRepository {
  Future<List<RevendaModel>> buscarTodasRevendas() async {
    var jsonFile = await rootBundle.loadString('assets/dados.json');
    var revendas = json.decode(jsonFile) as List;
    return revendas.map((r) => RevendaModel.fromMap(r)).toList();
  }
}
