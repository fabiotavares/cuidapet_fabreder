import 'package:cuidapet_fabreder/app/models/categoria_model.dart';
import 'package:cuidapet_fabreder/app/models/endereco_model.dart';
import 'package:cuidapet_fabreder/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet_fabreder/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_fabreder/app/services/categoria_service.dart';
import 'package:cuidapet_fabreder/app/services/endereco_service.dart';
import 'package:cuidapet_fabreder/app/services/fornecedor_service.dart';
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

  _HomeControllerBase(
    this._enderecoService,
    this._categoriaService,
    this._fornecedorService,
  );

  @observable
  EnderecoModel endereceSelecionado;

  @observable
  ObservableFuture<List<CategoriaModel>> categoriasFuture;

  @observable
  ObservableFuture<List<FornecedorBuscaModel>> estabelecimentosFuture;

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
    endereceSelecionado = prefs.enderecoSelecionado;
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
  void buscarEstabelecimentos() {
    try {
      estabelecimentosFuture = ObservableFuture(_fornecedorService.buscarFornecedoresProximos(endereceSelecionado));
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao buscar os fornecedores');
    }
  }
}
