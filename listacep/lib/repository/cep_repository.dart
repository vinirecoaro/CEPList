import 'package:listacep/model/cep_model.dart';
import 'package:listacep/repository/custon_dio.dart';

class CEPRepository {
  Future<CEPModel> obtainCEPs() async {
    var custonDio = CustonDio();
    var result = await custonDio.dio
        .get("https://parseapi.back4app.com/classes/Address");

    return CEPModel.fromJson(result.data);
  }

  Future<void> delete(String objectId) async {
    var custonDio = CustonDio();
    try {
      await custonDio.dio
          .delete("https://parseapi.back4app.com/classes/Address/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}
