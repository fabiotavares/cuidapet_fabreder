import 'package:cuidapet_fabreder/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet_fabreder/app/services/usuario_services.dart';
import 'package:cuidapet_fabreder/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UsuarioServices _service;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  @observable
  bool ocultaSenha = true;

  _LoginControllerBase(this._service);

  @action
  void toggleOcultaSenha() {
    ocultaSenha = !ocultaSenha;
  }

  @action
  Future<void> login() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await _service.login(facebookLogin: false, email: loginController.text, senha: senhaController.text);
        Loader.hide();
        // como tenho apenas a tela de login até aqui, essa chamada já vai eliminá-la
        Modular.to.pushReplacementNamed('/');
      } on AcessoNegadoException catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', 'Login ou senha inválidos');
      } catch (e) {
        Loader.hide();
        print('Erro: $e');
        Get.snackbar('Erro', 'Erro ao realizar login');
      }
    }
  }

  Future<void> facebookLogin() async {
    try {
      Loader.show();
      await _service.login(facebookLogin: true);
      Loader.hide();
      Modular.to.pushReplacementNamed('/');
    } on AcessoNegadoException catch (e) {
      Loader.hide();
      print(e);
      Get.snackbar('Erro', 'Login ou senha inválidos');
    } catch (e) {
      Loader.hide();
      print('Erro: $e');
      Get.snackbar('Erro', 'Erro ao realizar login');
    }
  }
}
