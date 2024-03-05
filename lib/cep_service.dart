import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cep_model.dart';

class CepService {
  final String _baseUrl = 'https://viacep.com.br/ws/';

  Future<CepModel> buscarCep(String cep) async {
    final response = await http.get(Uri.parse('$_baseUrl$cep/json/'));

    if (response.statusCode == 200) {
      return CepModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar o CEP');
    }
  }
}
