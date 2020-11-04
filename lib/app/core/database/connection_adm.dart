import 'package:cuidapet_fabreder/app/core/database/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

// permite acompanhar os ciclos do app e controlar o estado do bd
class ConnectionADM extends WidgetsBindingObserver with Disposable {
  var conn = Connection();

  ConnectionADM() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.inactive:
        conn.closeConnection();
        break;
      case AppLifecycleState.paused:
        conn.closeConnection();
        break;
      case AppLifecycleState.detached:
        conn.closeConnection();
        break;
    }
  }

  // método do Modular, que fica responsável por chamar quando o módulo for destruído
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
