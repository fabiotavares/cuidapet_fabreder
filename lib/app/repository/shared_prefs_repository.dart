// usando o plugin Shered Preferences para armazenar dados não criptografados
import 'dart:convert';

import 'package:cuidapet_fabreder/app/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

// singleton
class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/_ACCESS_TOKEN/';
  static const _DEVICE_ID = '/_DEVICE_ID/';
  static const _USER_DATA = '/_USER_DATA/';

  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository;
  }

  // acesso ao access token
  Future<void> registerAccessToken(String token) async {
    await prefs.setString(_ACCESS_TOKEN, token);
  }

  String get accessToken => prefs.get(_ACCESS_TOKEN);

  // acesso ao device id
  Future<void> registerDeviceId(String deviceId) async {
    await prefs.setString(_DEVICE_ID, deviceId);
  }

  String get deviceId => prefs.get(_DEVICE_ID);

  // acesso ao dados do usuário
  Future<void> registerUserData(UsuarioModel user) async {
    await prefs.setString(_USER_DATA, jsonEncode(user));
  }

  UsuarioModel get userData {
    if (prefs.containsKey(_USER_DATA)) {
      Map<String, dynamic> usuarioMapa = jsonDecode(prefs.getString(_USER_DATA));
      return UsuarioModel.fromJson(usuarioMapa);
    }
    return null;
  }

  void logout() {
    prefs.clear();
    // redireciona para a home
    Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/')); // até que chegue na barra
  }
}
