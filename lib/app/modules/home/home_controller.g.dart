// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(
      i<EnderecoService>(), i<CategoriaService>(), i<FornecedorService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$endereceSelecionadoAtom =
      Atom(name: '_HomeControllerBase.endereceSelecionado');

  @override
  EnderecoModel get endereceSelecionado {
    _$endereceSelecionadoAtom.reportRead();
    return super.endereceSelecionado;
  }

  @override
  set endereceSelecionado(EnderecoModel value) {
    _$endereceSelecionadoAtom.reportWrite(value, super.endereceSelecionado, () {
      super.endereceSelecionado = value;
    });
  }

  final _$categoriasFutureAtom =
      Atom(name: '_HomeControllerBase.categoriasFuture');

  @override
  ObservableFuture<List<CategoriaModel>> get categoriasFuture {
    _$categoriasFutureAtom.reportRead();
    return super.categoriasFuture;
  }

  @override
  set categoriasFuture(ObservableFuture<List<CategoriaModel>> value) {
    _$categoriasFutureAtom.reportWrite(value, super.categoriasFuture, () {
      super.categoriasFuture = value;
    });
  }

  final _$estabelecimentosFutureAtom =
      Atom(name: '_HomeControllerBase.estabelecimentosFuture');

  @override
  ObservableFuture<List<FornecedorBuscaModel>> get estabelecimentosFuture {
    _$estabelecimentosFutureAtom.reportRead();
    return super.estabelecimentosFuture;
  }

  @override
  set estabelecimentosFuture(
      ObservableFuture<List<FornecedorBuscaModel>> value) {
    _$estabelecimentosFutureAtom
        .reportWrite(value, super.estabelecimentosFuture, () {
      super.estabelecimentosFuture = value;
    });
  }

  final _$pageSelecionadaAtom =
      Atom(name: '_HomeControllerBase.pageSelecionada');

  @override
  int get pageSelecionada {
    _$pageSelecionadaAtom.reportRead();
    return super.pageSelecionada;
  }

  @override
  set pageSelecionada(int value) {
    _$pageSelecionadaAtom.reportWrite(value, super.pageSelecionada, () {
      super.pageSelecionada = value;
    });
  }

  final _$initPageAsyncAction = AsyncAction('_HomeControllerBase.initPage');

  @override
  Future<void> initPage() {
    return _$initPageAsyncAction.run(() => super.initPage());
  }

  final _$recuperarEnderecoSelecionadoAsyncAction =
      AsyncAction('_HomeControllerBase.recuperarEnderecoSelecionado');

  @override
  Future<void> recuperarEnderecoSelecionado() {
    return _$recuperarEnderecoSelecionadoAsyncAction
        .run(() => super.recuperarEnderecoSelecionado());
  }

  final _$temEnderecoCadastradoAsyncAction =
      AsyncAction('_HomeControllerBase.temEnderecoCadastrado');

  @override
  Future<void> temEnderecoCadastrado() {
    return _$temEnderecoCadastradoAsyncAction
        .run(() => super.temEnderecoCadastrado());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void setPageSelecionada(int value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setPageSelecionada');
    try {
      return super.setPageSelecionada(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buscarCategorias() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.buscarCategorias');
    try {
      return super.buscarCategorias();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buscarEstabelecimentos() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.buscarEstabelecimentos');
    try {
      return super.buscarEstabelecimentos();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
endereceSelecionado: ${endereceSelecionado},
categoriasFuture: ${categoriasFuture},
estabelecimentosFuture: ${estabelecimentosFuture},
pageSelecionada: ${pageSelecionada}
    ''';
  }
}
