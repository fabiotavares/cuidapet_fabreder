import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
              onPressed: () {
                Get.showSnackbar(GetBar(
                  title: 'Olá',
                  message: 'Fábio Tavares',
                  duration: Duration(seconds: 2),
                ));
              },
              child: Text('Snack Bar Fácil'))
        ],
      ),
    );
  }
}
