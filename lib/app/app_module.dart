import 'package:cuidapet_fabreder/app/core/database/connection_adm.dart';
import 'package:cuidapet_fabreder/app/modules/home/home_module.dart';
import 'package:cuidapet_fabreder/app/modules/login/login_module.dart';
import 'package:cuidapet_fabreder/app/modules/main_page/main_page.dart';
import 'package:cuidapet_fabreder/app/repository/usuario_repository.dart';
import 'package:cuidapet_fabreder/app/services/usuario_service.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet_fabreder/app/app_widget.dart';
import 'package:cuidapet_fabreder/app/shared/auth_store.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => ConnectionADM(), lazy: false),
        Bind((i) => AuthStore()),
        Bind((i) => UsuarioRepository()),
        Bind((i) => UsuarioService(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (context, args) => MainPage()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/login', module: LoginModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
