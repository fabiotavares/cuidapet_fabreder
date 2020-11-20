import 'package:cuidapet_fabreder/app/modules/home/enderecos/detalhe/detalhe_page.dart';

import 'detalhe/detalhe_controller.dart';
import 'enderecos_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'enderecos_page.dart';

class EnderecosModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => DetalheController(i.get())), //não precisa mais i.get()
        Bind((i) => EnderecosController(i())), //não precisa mais i.get()
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => EnderecosPage()),
        // repassando os argumentos (de enderecos_controller) para o construtor de detalhepage
        ModularRouter('/detalhe', child: (_, args) => DetalhePage(enderecoModel: args.data)),
      ];

  static Inject get to => Inject<EnderecosModule>.of();
}
