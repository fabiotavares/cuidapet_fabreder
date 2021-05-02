import 'package:cuidapet_fabreder/app/models/categoria_model.dart';
import 'package:cuidapet_fabreder/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet_fabreder/app/modules/home/components/estabelecimento_item_grid.dart';
import 'package:cuidapet_fabreder/app/modules/home/components/estabelecimento_item_lista.dart';
import 'package:cuidapet_fabreder/app/modules/home/components/home_appbar.dart';
import 'package:cuidapet_fabreder/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  // atributo para controlar a troca do PageView
  final _estabelecimentoPageController = PageController(initialPage: 0);

  // variável para facilitar a escolha do ícone da categoria
  final categoriasIcons = {
    'P': Icons.pets,
    'V': Icons.local_hospital,
    'C': Icons.store_mall_directory,
  };

  @override
  void initState() {
    super.initState();
    // um bom padrão a ser seguido
    controller.initPage();
  }

  @override
  Widget build(BuildContext context) {
    // externalizando componente
    final myAppBar = HomeAppBar(controller);

    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.grey[100],
      appBar: myAppBar,
      body: RefreshIndicator(
        onRefresh: () => controller.buscarEstabelecimentos(),
        child: SingleChildScrollView(
          // necessário para permitir a rolagem pro refreshIndicator, mesmo que não tenha extrapolado o tamanho da tela
          physics: AlwaysScrollableScrollPhysics(),
          // após incluir o singlechildscrollview, coloquei o container envolvendo a column
          child: Container(
            padding: EdgeInsets.only(top: 20),
            width: ScreenUtil().screenWidth,
            // muita atenção nesse desconto pra altura da tela ficar certinha
            height: ScreenUtil().screenHeight - (myAppBar.preferredSize.height + ScreenUtil().statusBarHeight),
            child: Column(
              children: <Widget>[
                // endereço corrente...
                _buildEndereco(),
                SizedBox(height: 10),
                // lista de categorias...
                _buildCategorias(),
                // lista de estabelecimentos localizados
                Expanded(child: _buildEstabelecimentos()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // retorna dados do endereço atual
  Widget _buildEndereco() {
    return Container(
      child: Column(
        children: [
          Text('Estabelecimentos próximos de '),
          // observer para refletir as alterações
          Observer(builder: (_) {
            return Text(
              //se não for nula pega o atributo, senão coloca vazio
              controller.enderecoSelecionado?.endereco ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            );
          }),
        ],
      ),
    );
  }

  // retorna lista de categorias
  Widget _buildCategorias() {
    // FutureBuilder para acompanhar a busca das categorias
    return Observer(builder: (_) {
      return FutureBuilder<List<CategoriaModel>>(
        future: controller.categoriasFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              // verifica se tem algum erro
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao buscar categorias'),
                );
              }

              // confirmar se tem algum dado
              if (snapshot.hasData) {
                var cats = snapshot.data;

                return Container(
                  // o listview precisa de um pai com um tamanho definido
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // shrink => remonta a cada item que incluir
                    shrinkWrap: true,
                    itemCount: cats.length,
                    itemBuilder: (context, index) {
                      var cat = cats[index];
                      // construção do circulo com icone e desenho embaixo
                      return InkWell(
                        onTap: () => controller.filtrarEstabelecimentosPorCategora(cat.id),
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Observer(builder: (_) {
                                return CircleAvatar(
                                  backgroundColor: controller.categoriaSelecionada == cat.id ? ThemeUtils.primaryColor : ThemeUtils.primaryColorLight,
                                  child: Icon(categoriasIcons[cat.tipo], size: 30, color: Colors.black),
                                  // tamanho do avatar:
                                  radius: 30,
                                );
                              }),
                              SizedBox(height: 10),
                              Text(cat.nome),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                // não tem dados pra mostrar
                return Center(
                  child: Text('Nenhuma categoria pra exibir'),
                );
              }
              break;
            default:
              return Container();
          }
        },
      );
    });
  }

  // retorna lista de estabelecimentos encontrados próximos
  Widget _buildEstabelecimentos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Observer(builder: (_) {
            return Row(
              children: [
                Text('Estabelecimentos'),
                Spacer(), // lega... esse spacer já expande
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Icon(
                      Icons.view_headline,
                      color: controller.pageSelecionada == 0 ? Colors.black : Colors.grey,
                    ),
                    onTap: () {
                      _estabelecimentoPageController.previousPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Icon(
                      Icons.view_comfy,
                      color: controller.pageSelecionada == 1 ? Colors.black : Colors.grey,
                    ),
                    onTap: () {
                      _estabelecimentoPageController.nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
        // usando pageView para permitir os dois tipos de vissualizações
        Expanded(
          child: PageView(
            controller: _estabelecimentoPageController,
            onPageChanged: (value) => controller.setPageSelecionada(value),
            // pra não permitir rolar manualmente
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildEstabelecimentosLista(),
              _buildEstabelecimentosGrid(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEstabelecimentosLista() {
    // lista de estabelecimentos com separador
    return Observer(builder: (_) {
      return FutureBuilder<List<FornecedorBuscaModel>>(
        future: controller.estabelecimentosFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:

              // verifica se tem algum erro
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao buscar estabelecimentos'),
                );
              }

              // confirmar se tem algum dado
              if (snapshot.hasData) {
                final fornecs = snapshot.data;
                return ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: fornecs.length,
                  separatorBuilder: (_, index) => Divider(
                    // não preciso de cor, apenas uma separação entre os itens da lista
                    color: Colors.transparent,
                  ),
                  itemBuilder: (context, index) {
                    final fornec = fornecs[index];
                    return EstabelecimentoItemLista(fornec);
                  },
                );
              } else {
                // não tem dados pra mostrar
                return Center(
                  child: Text('Nenhum estabelecimento pra exibir'),
                );
              }
              break;
            default:
              return Container();
          }
        },
      );
    });
  }

  Widget _buildEstabelecimentosGrid() {
    return Observer(builder: (_) {
      return FutureBuilder<List<FornecedorBuscaModel>>(
        future: controller.estabelecimentosFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:

              // verifica se tem algum erro
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao buscar estabelecimentos'),
                );
              }

              // confirmar se tem algum dado
              if (snapshot.hasData) {
                final fornecs = snapshot.data;
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: fornecs.length,
                  itemBuilder: (context, index) {
                    final fornec = fornecs[index];
                    return EstabelecimentoItemGrid(fornec);
                  },
                  // Diz como será cosntruído o grid...
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                  ),
                );
              } else {
                // não tem dados pra mostrar
                return Center(
                  child: Text('Nenhum estabelecimento pra exibir'),
                );
              }
              break;
            default:
              return Container();
          }
        },
      );
    });
  }
}
