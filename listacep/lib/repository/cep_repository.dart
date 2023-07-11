import 'package:listacep/model/cep_model.dart';
import 'package:listacep/repository/custon_dio_back4app.dart';

class CEPRepository {
  Future<CEPsModel> obtainCEPs() async {
    var custonDio = CustonDioBack4App();
    var result = await custonDio.dio
        .get("https://parseapi.back4app.com/classes/Address");

    return CEPsModel.fromJson(result.data);
  }

  Future<void> delete(String objectId) async {
    var custonDio = CustonDioBack4App();
    try {
      await custonDio.dio
          .delete("https://parseapi.back4app.com/classes/Address/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}
