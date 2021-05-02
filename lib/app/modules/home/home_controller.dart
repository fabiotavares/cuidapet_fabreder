import 'package:cuidapet_fabreder/app/models/categoria_model.dart';
import 'package:cuidapet_fabreder/app/models/endereco_model.dart';
import 'package:cuidapet_fabreder/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet_fabreder/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_fabreder/app/services/categoria_service.dart';
import 'package:cuidapet_fabreder/app/services/endereco_service.dart';
import 'package:cuidapet_fabreder/app/services/fornecedor_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final EnderecoService _enderecoService;
  final CategoriaService _categoriaService;
  final FornecedorService _fornecedorService;
  final filtroNomeController = TextEditingController();

  _HomeControllerBase(
    this._enderecoService,
    this._categoriaService,
    this._fornecedorService,
  );

  @observable
  EnderecoModel enderecoSelecionado;

  @observable
  ObservableFuture<List<CategoriaModel>> categoriasFuture;

  @observable
  ObservableFuture<List<FornecedorBuscaModel>> estabelecimentosFuture;

  // lista auxiliar que será usada como cache para os filtros
  // permite filtrar a lista exibida sem perder a busca de fornecedores já realizada
  // essa estratégia é boa neste caso onde o número de estabelecimentos próximo é pequeno...
  // ...se fosse algo muito grande, seria melhor refazer a requisição pro backend
  List<FornecedorBuscaModel> estabelecimentosOriginais;

  @observable
  int categoriaSelecionada;

  // use obx pra criar um getter e setter do mobix
  @observable
  int pageSelecionada = 0;

  @action
  void setPageSelecionada(int value) => pageSelecionada = value;

  @action
  Future<void> initPage() async {
    // initPage é um padrão que ajuda a centralizar a inicialização da página
    await temEnderecoCadastrado();
    await recuperarEnderecoSelecionado();
    buscarCategorias();
    buscarEstabelecimentos();
  }

  @action
  void buscarCategorias() {
    try {
      categoriasFuture = ObservableFuture(_categoriaService.buscarCategorias());
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao buscar as categorias');
    }
  }

  @action
  Future<void> recuperarEnderecoSelecionado() async {
    var prefs = await SharedPrefsRepository.instance;
    enderecoSelecionado = prefs.enderecoSelecionado;
    if (enderecoSelecionado == null) {
      // ficar esperando o retorno da tela de endereços
      // o link permite usar o link parcial
      // await Modular.link.pushNamed('/enderecos');
      await Modular.to.pushNamed('/home/enderecos');
      enderecoSelecionado = prefs.enderecoSelecionado;
    }
  }

  @action
  Future<void> temEnderecoCadastrado() async {
    final temEndereco = await _enderecoService.existeEnderecoCadastrado();
    if (!temEndereco) {
      // ficar esperando o retorno da tela de endereços
      // o link permite usar o link parcial
      // await Modular.link.pushNamed('/enderecos');
      await Modular.to.pushNamed('/home/enderecos');
    }
  }

  @action
  Future<void> buscarEstabelecimentos() async {
    try {
      // limpando filtros...
      categoriaSelecionada = null;
      filtroNomeController.text = '';

      estabelecimentosFuture = ObservableFuture(_fornecedorService.buscarFornecedoresProximos(enderecoSelecionado));
      // populando a lista que será usada nos filtros (tipo um cache)
      estabelecimentosOriginais = await estabelecimentosFuture;
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao buscar os fornecedores');
    }
  }

  @action
  void filtrarEstabelecimentosPorCategora(int id) {
    // lógica para selecionar a categoria (ou retirar a seleção)
    if (categoriaSelecionada == id) {
      // então devo retirar o filtro
      categoriaSelecionada = null;
    } else {
      // insere o filtro
      categoriaSelecionada = id;
    }
    _filtrarEstabelecimentos();
  }

  @action
  void filtrarEstabelecimentosPorNome() {
    _filtrarEstabelecimentos();
  }

  @action
  void _filtrarEstabelecimentos() {
    // lista sem filtro
    var fornecedores = estabelecimentosOriginais;

    // possível filtro duplo
    if (categoriaSelecionada != null) {
      fornecedores = fornecedores.where((e) => e.categoria.id == categoriaSelecionada).toList();
    }

    if (filtroNomeController.text.trim().isNotEmpty) {
      fornecedores = fornecedores.where((e) => e.nome.toLowerCase().contains(filtroNomeController.text.toLowerCase())).toList();
    }

    // atualizando a lista exibida passando um futuro a partir de uma lista pré-existente
    // esta é uma boa estratégia para aproveitar os recursos que o FutureBuilder oferece
    estabelecimentosFuture = ObservableFuture(Future.value(fornecedores));
  }
}
