import 'dart:io';

import 'package:cuidapet_fabreder/app/core/dio/custom_dio.dart';
import 'package:cuidapet_fabreder/app/models/access_token_model.dart';
import 'package:cuidapet_fabreder/app/models/confirm_login_model.dart';
import 'package:cuidapet_fabreder/app/repository/shared_prefs_repository.dart';

class UsuarioRepository {
  Future<AccessTokenModel> login(String email, {String password, bool facebookLogin = false, String avatar = ''}) {
    // login pelo facebook já implica em um cadastro automático
    // o avatar será a imagem do usuário, que pode vir do facebook

    // usando instance pois é apenas o login, onde obterei o token
    // apenas '/login' pois CustomDio já encapsula a base_url

    // fazendo login no backend
    return CustomDio.instance.post('/login', data: {
      'login': email,
      'senha': password,
      'facebookLogin': facebookLogin,
      'avatar': avatar,
    }).then((res) => AccessTokenModel.fromJson(res.data));
  }

  // confirmando login
  Future<ConfirmLoginModel> confirmLogin() async {
    final prefs = await SharedPrefsRepository.instance;
    final deviceId = prefs.deviceId;

    // uso de 'patch' pois vai alterar um dado
    return CustomDio.authInstance.patch('/login/confirmar', data: {
      'ios_token': Platform.isIOS ? deviceId : null,
      'android_token': Platform.isAndroid ? deviceId : null,
    }).then((res) => ConfirmLoginModel.fromJson(res.data));
  }

  // vou deixar o serviço tratar os possíveis erros
}
