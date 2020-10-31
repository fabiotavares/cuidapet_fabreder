import 'package:cuidapet_fabreder/app/repository/security_storage_repository.dart';
import 'package:cuidapet_fabreder/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_fabreder/app/repository/usuario_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UsuarioServices {
  final UsuarioRepository _repository;

  UsuarioServices(this._repository);

  Future<void> login(String email, {String password, bool facebookLogin = false, String avatar = ''}) async {
    try {
      // chamando o login do repository (login no backend)
      final accessTokenModel =
          await _repository.login(email, password: password, facebookLogin: facebookLogin, avatar: avatar);

      final prefs = await SharedPrefsRepository.instance;

      // se não for login pelo facebook, faz login com email e senha no firebase
      if (!facebookLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        // registrando o token
        prefs.registerAccessToken(accessTokenModel.accessToken);
      } else {}

      // confirmando login (independente de ser pro facebook ou não)
      final confirmModel = await _repository.confirmLogin();
      prefs.registerAccessToken(confirmModel.accessToken);
      SecurityStorageRepository().registerRefreshToken(confirmModel.refreshToken);

      //
    } on PlatformException catch (e) {
      // erro específico do firebase
      // repassando a excessão, pois é a controller que informará na tela
      print('Erro ao fazer login no Firebase $e');
      rethrow;
    } catch (e) {
      // repassando a excessão, pois é a controller que informará na tela
      print('Erro ao fazer login $e');
      rethrow;
    }
  }
}
