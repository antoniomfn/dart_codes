import 'package:dio/dio.dart';
import 'package:desafio_dart_avancado/models/cidades_model.dart';

Future<List<Cidades>> getCidades(int id) async {
  var dio = Dio();
  var response = await dio.get<List>(
      'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$id/distritos');

  if (response.statusCode == 200) {
    var cidades = response.data.map((e) => Cidades.fromMap(e)).toList();
    return cidades;
  }

  return null;
}
