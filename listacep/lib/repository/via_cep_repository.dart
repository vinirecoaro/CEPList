import 'package:dio/dio.dart';
import '../model/cep_model.dart';

class ViaCEPRepository {
  Future<CEPModel> consultarCEP(String cep) async {
    var dio = Dio();
    var response = await dio.get("https://viacep.com.br/ws/$cep/json/");
    return CEPModel.fromJson(response.data);
  }
}
