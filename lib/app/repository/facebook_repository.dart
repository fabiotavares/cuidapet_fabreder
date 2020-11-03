import 'dart:convert';

import 'package:cuidapet_fabreder/app/core/dio/custom_dio.dart';
import 'package:cuidapet_fabreder/app/models/facebook_model.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookRepository {
  Future<FacebookModel> login() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['public_profile', 'email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        // pegando os demais dados do facebook que o plugin não fornece
        final resultFacebook = await CustomDio.instance.get('https://graph.facebook.com/v4.0/me?fields=birthday,name,first_name,last_name,email,picture,link&access_token=$token');
        // convertendo a string recebida em um mapa (imagem)
        var model = FacebookModel.fromJson(json.decode(resultFacebook.data));
        model.token = token;
        return model;
        break;
      case FacebookLoginStatus.cancelledByUser:
        return null;
        break;
      case FacebookLoginStatus.error:
        throw Exception(result.errorMessage);
        break;
      default:
        return null;
    }
  }
}
