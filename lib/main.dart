import 'package:flutter/material.dart';
import 'package:cuidapet_fabreder/app/app_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // método que força a inicialização do contexto antes do do runApp
  WidgetsFlutterBinding.ensureInitialized();
  // inicializando o firebase
  await Firebase.initializeApp();
  // forçando orientação retrato para o app como única opção
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(ModularApp(module: AppModule()));
}
