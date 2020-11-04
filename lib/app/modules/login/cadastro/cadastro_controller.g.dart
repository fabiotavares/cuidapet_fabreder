// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CadastroController on _CadastroControllerBase, Store {
  final _$ocultaSenhaAtom = Atom(name: '_CadastroControllerBase.ocultaSenha');

  @override
  bool get ocultaSenha {
    _$ocultaSenhaAtom.reportRead();
    return super.ocultaSenha;
  }

  @override
  set ocultaSenha(bool value) {
    _$ocultaSenhaAtom.reportWrite(value, super.ocultaSenha, () {
      super.ocultaSenha = value;
    });
  }

  final _$ocultaConfirmaSenhaAtom =
      Atom(name: '_CadastroControllerBase.ocultaConfirmaSenha');

  @override
  bool get ocultaConfirmaSenha {
    _$ocultaConfirmaSenhaAtom.reportRead();
    return super.ocultaConfirmaSenha;
  }

  @override
  set ocultaConfirmaSenha(bool value) {
    _$ocultaConfirmaSenhaAtom.reportWrite(value, super.ocultaConfirmaSenha, () {
      super.ocultaConfirmaSenha = value;
    });
  }

  final _$cadastrarUsuarioAsyncAction =
      AsyncAction('_CadastroControllerBase.cadastrarUsuario');

  @override
  Future<void> cadastrarUsuario() {
    return _$cadastrarUsuarioAsyncAction.run(() => super.cadastrarUsuario());
  }

  final _$_CadastroControllerBaseActionController =
      ActionController(name: '_CadastroControllerBase');

  @override
  void toggleOcultaSenha() {
    final _$actionInfo = _$_CadastroControllerBaseActionController.startAction(
        name: '_CadastroControllerBase.toggleOcultaSenha');
    try {
      return super.toggleOcultaSenha();
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleOcultaConfirmaSenha() {
    final _$actionInfo = _$_CadastroControllerBaseActionController.startAction(
        name: '_CadastroControllerBase.toggleOcultaConfirmaSenha');
    try {
      return super.toggleOcultaConfirmaSenha();
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ocultaSenha: ${ocultaSenha},
ocultaConfirmaSenha: ${ocultaConfirmaSenha}
    ''';
  }
}
