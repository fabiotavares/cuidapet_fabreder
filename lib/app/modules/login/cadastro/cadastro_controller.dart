import 'package:cuidapet_fabreder/app/services/usuario_service.dart';
import 'package:cuidapet_fabreder/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'cadastro_controller.g.dart';

@Injectable()
class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  final UsuarioService _service;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmaSenhaController = TextEditingController();

  @observable
  bool ocultaSenha = true;

  @observable
  bool ocultaConfirmaSenha = true;

  _CadastroControllerBase(this._service);

  @action
  void toggleOcultaSenha() {
    ocultaSenha = !ocultaSenha;
  }

  @action
  void toggleOcultaConfirmaSenha() {
    ocultaConfirmaSenha = !ocultaConfirmaSenha;
  }

  @action
  Future<void> cadastrarUsuario() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await _service.cadastrarUsuario(loginController.text, senhaController.text);
        Loader.hide();
        Modular.to.pop();
        Get.snackbar('Sucesso', 'Usuário cadastrado com sucesso');
      } catch (e) {
        Loader.hide();
        Get.snackbar('Erro', 'Erro ao cadastrar usuário');
        print('Erro ao cadastrar usuário: $e');
      }
    }
  }
}
