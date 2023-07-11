import 'package:listacep/model/cep_model.dart';
import 'package:listacep/repository/custon_dio_back4app.dart';
import 'package:listacep/repository/via_cep_repository.dart';

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

  Future<void> create(String cep) async {
    var custonDio = CustonDioBack4App();
    var viaCEPRepository = ViaCEPRepository();
    var cepModel = CEPModel.empty();
    cepModel = await viaCEPRepository.CEPQuery(cep);
    try {
      await custonDio.dio.post("https://parseapi.back4app.com/classes/Address",
          data: cepModel.toCreateJson());
    } catch (e) {
      rethrow;
    }
  }
}
