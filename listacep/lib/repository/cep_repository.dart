import 'package:dio/dio.dart';
import 'package:listacep/model/cep_model.dart';

class CEPRepository {
  Future<CEPModel> obtainCEPs() async {
    var _dio = Dio();
    _dio.options.headers["X-Parse-Application-Id"] =
        "dKWz560sEmzsPS9YJfD7ZR4C1v5WU6w2LarwrxL9";
    _dio.options.headers["X-Parse-REST-API-Key"] =
        "E6GpMhm6TsDtu3DgW3jtT5PbuPBwALFM2AwPIk1E";
    _dio.options.headers["Content-Type"] = "application/json";
    var result =
        await _dio.get("https://parseapi.back4app.com/classes/Address");

    return CEPModel.fromJson(result.data);
  }
}
