import 'package:cuidapet_fabreder/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet_fabreder/app/models/access_token_model.dart';
import 'package:cuidapet_fabreder/app/repository/facebook_repository.dart';
import 'package:cuidapet_fabreder/app/repository/security_storage_repository.dart';
import 'package:cuidapet_fabreder/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_fabreder/app/repository/usuario_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsuarioServices {
  final UsuarioRepository _repository;

  UsuarioServices(this._repository);

  Future<void> login({
    @required bool facebookLogin,
    String email,
    String senha,
  }) async {
    try {
      final prefs = await SharedPrefsRepository.instance;
      final fireAuth = FirebaseAuth.instance;
      AccessTokenModel accessTokenModel;

      if (!facebookLogin) {
        // login no backend
        accessTokenModel = await _repository.login(email, senha: senha, facebookLogin: facebookLogin, avatar: '');
        // login no firebase
        await fireAuth.signInWithEmailAndPassword(email: email, password: senha);
      } else {
        // login no facebook
        var facebookModel = await FacebookRepository().login();
        if (facebookModel != null) {
          // login no backend
          accessTokenModel = await _repository.login(facebookModel.email, senha: senha, facebookLogin: facebookLogin, avatar: facebookModel.picture);
          // login no firebase
          final facebookCredencial = FacebookAuthProvider.credential(facebookModel.token);
          fireAuth.signInWithCredential(facebookCredencial);
        } else {
          throw AcessoNegadoException('Acesso Negado');
        }
      }

      // se chegou até aqui, login com sucesso...
      // registrando o token
      prefs.registerAccessToken(accessTokenModel.accessToken);

      // confirmando login (independente de ser pro facebook ou não)
      final confirmModel = await _repository.confirmLogin();
      prefs.registerAccessToken(confirmModel.accessToken);
      SecurityStorageRepository().registerRefreshToken(confirmModel.refreshToken);

      // salvar dados do usuário
      final dadosUsuario = await _repository.recuperaDadosUsuarioLogado();
      await prefs.registerUserData(dadosUsuario);

      //
    } on PlatformException catch (e) {
      // erro específico do firebase
      // repassando a excessão, pois é a controller que informará na tela
      print('Erro ao fazer login no Firebase $e');
      rethrow;
    } on DioError catch (e) {
      // erro específico do Dio
      if (e.response.statusCode == 403) {
        // envia exceção customizada
        throw AcessoNegadoException(e.response.data['message'], exception: e);
      } else {
        rethrow;
      }
    } catch (e) {
      // repassando a excessão, pois é a controller que informará na tela
      print('Erro ao fazer login $e');
      rethrow;
    }
  }
}
