import 'package:flutter/material.dart';
import 'package:listacep/model/cep_model.dart';
import 'package:listacep/repository/cep_repository.dart';
import 'package:listacep/shared/card_label.dart';

class CepListPage extends StatefulWidget {
  const CepListPage({super.key});

  @override
  State<CepListPage> createState() => _CepListPageState();
}

class _CepListPageState extends State<CepListPage> {
  var _ceps = CEPModel([]);
  CEPRepository cepRepository = CEPRepository();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    _ceps = await cepRepository.obtainCEPs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("CEP's"),
      ),
      body: ListView.builder(
        itemCount: _ceps.results.length,
        itemBuilder: (BuildContext bc, int index) {
          var cep = _ceps.results[index];
          return Dismissible(
            onDismissed: (DismissDirection dismissDirection) async {
              await cepRepository.delete(cep.objectId);
              loadData();
            },
            key: Key(cep.objectId),
            child: CardLabel(
                cepNumber: cep.cep,
                logradouro: cep.logradouro,
                bairro: cep.bairro,
                localidade: cep.localidade,
                uf: cep.uf),
          );
        },
      ),
    ));
  }
}
