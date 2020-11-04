import 'package:cuidapet_fabreder/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_fabreder/app/shared/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Modular.get<AuthStore>().usuarioLogado.email),
            FlatButton(
                onPressed: () async {
                  (await SharedPrefsRepository.instance).logout();
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
