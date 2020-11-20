import 'package:cuidapet_fabreder/app/modules/home/enderecos/enderecos_module.dart';
import 'package:cuidapet_fabreder/app/repository/categoria_repository.dart';
import 'package:cuidapet_fabreder/app/services/categoria_service.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i.get(), i.get(), i.get())),
        // injeção de categorias (vai aqui pois só será usada na home)
        Bind((i) => CategoriaRepository()),
        Bind((i) => CategoriaService(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/enderecos', module: EnderecosModule()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
