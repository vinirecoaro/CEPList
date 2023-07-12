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
  var _ceps = CEPsModel([]);
  CEPRepository cepRepository = CEPRepository();
  var cepController = TextEditingController();

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cepController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Adicionar CEP"),
                  content: Wrap(
                    children: [
                      TextField(
                        controller: cepController,
                        keyboardType: TextInputType.number,
                        maxLength: 8,
                        onChanged: (String value) {
                          value.replaceAll(RegExp(r'[^0-9]'), '');
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          try {
                            await cepRepository.create(cepController.text);
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('CEP não encontrado'),
                            ));
                          }
                          Navigator.pop(context);
                          loadData();
                        },
                        child: const Text("Salvar"))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _ceps.ceps.length,
        itemBuilder: (BuildContext bc, int index) {
          var cep = _ceps.ceps[index];
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
