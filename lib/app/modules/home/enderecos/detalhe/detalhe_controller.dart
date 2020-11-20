import 'package:cuidapet_fabreder/app/models/endereco_model.dart';
import 'package:cuidapet_fabreder/app/services/endereco_service.dart';
import 'package:cuidapet_fabreder/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'detalhe_controller.g.dart';

@Injectable()
class DetalheController = _DetalheControllerBase with _$DetalheController;

abstract class _DetalheControllerBase with Store {
  final EnderecoService _enderecoService;
  final complementoTextController = TextEditingController();

  _DetalheControllerBase(this._enderecoService);

  Future<void> salvarEndereco(EnderecoModel model) async {
    try {
      Loader.show();
      model.complemento = complementoTextController.text;
      await _enderecoService.salvarEndereco(model);
      Loader.hide();
      Modular.to.pop();
    } catch (e) {
      Loader.hide();
      print('Erro ao salvar endereço: $e');
      Get.snackbar('Erro', 'Erro ao salvar endereço');
    }
  }
}
