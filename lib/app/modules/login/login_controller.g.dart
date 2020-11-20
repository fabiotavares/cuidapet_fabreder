// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $LoginController = BindInject(
  (i) => LoginController(i<UsuarioService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$ocultaSenhaAtom = Atom(name: '_LoginControllerBase.ocultaSenha');

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

  final _$loginAsyncAction = AsyncAction('_LoginControllerBase.login');

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  void toggleOcultaSenha() {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.toggleOcultaSenha');
    try {
      return super.toggleOcultaSenha();
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ocultaSenha: ${ocultaSenha}
    ''';
  }
}
