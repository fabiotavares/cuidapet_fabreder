import 'package:cuidapet_fabreder/app/modules/home/home_controller.dart';
import 'package:cuidapet_fabreder/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_fabreder/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// personalizando widget...
class HomeAppBar extends PreferredSize {
  final HomeController controller;
  HomeAppBar(this.controller)
      : super(
          preferredSize: Size(double.infinity, 100),
          child: AppBar(
              backgroundColor: Colors.grey[100],
              title: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text('Cuidapet', style: TextStyle(color: Colors.white)),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () async {
                    // temp: fazer logout
                    final prefs = await SharedPrefsRepository.instance;
                    prefs.logout();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.location_on),
                  // onPressed: () => Modular.link.pushNamed('/enderecos'),
                  onPressed: () async {
                    await Modular.to.pushNamed('/home/enderecos');
                    // atualizar a home...
                    await controller.recuperarEnderecoSelecionado();
                    // atualiza lista de estabelecimentos...
                    await controller.buscarEstabelecimentos();
                  },
                ),
              ],
              elevation: 0,
              // construindo o campo de pesquisa diferenciado
              flexibleSpace: Stack(
                children: [
                  Container(
                    // é esse camarada que está colocando a cor verde
                    height: 115,
                    width: double.infinity,
                    color: ThemeUtils.primaryColor,
                  ),
                  // Align? novidade pra mim!!
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: ScreenUtil().screenWidth * .9,
                      child: Material(
                        // material pra colocar um elevation no campo de pesqusia
                        elevation: 4,
                        borderRadius: BorderRadius.circular(30),
                        child: Observer(builder: (_) {
                          return TextFormField(
                            onChanged: (value) => controller.filtrarEstabelecimentosPorNome(),
                            controller: controller.filtroNomeController,
                            decoration: InputDecoration(
                              // fillColor e filled precisam ser configurados em conjunto
                              fillColor: Colors.white,
                              filled: true,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Icon(Icons.search, size: 30),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.grey[200]),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.grey[200]),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.grey[200]),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              )),
        );
}
