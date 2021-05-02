import 'dart:io';

import 'package:cuidapet_fabreder/app/shared/components/facebook_button.dart';
import 'package:cuidapet_fabreder/app/shared/theme_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          // width: ScreenUtil().screenWidth,
          // height: ScreenUtil().screenHeight,
          child: Stack(
            children: [
              Container(
                // fundo com a imagem de backgroud
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight < 700
                    ? ScreenUtil().screenHeight * .95 //700
                    : ScreenUtil().screenHeight * .95,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('lib/assets/images/login_background.png'),
                  fit: BoxFit.fill,
                )),
              ),
              // logo
              Container(
                // descontando o tamanho da status bar
                margin: EdgeInsets.only(
                    top: Platform.isIOS ? ScreenUtil().statusBarHeight + 30 : ScreenUtil().statusBarHeight),
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset(
                      'lib/assets/images/logo.png',
                      width: ScreenUtil().setWidth(400),
                      fit: BoxFit.fill,
                    ),
                    _buildForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            // login...
            TextFormField(
              controller: controller.loginController,
              decoration: InputDecoration(
                labelText: 'Login',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  gapPadding: 0, // estaço na borda
                ),
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'Login obrigatório';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            // senha...
            Observer(builder: (_) {
              return TextFormField(
                controller: controller.senhaController,
                obscureText: controller.ocultaSenha,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    gapPadding: 0, // estaço na borda
                  ),
                  suffixIcon: IconButton(
                    icon: controller.ocultaSenha ? Icon(Icons.lock) : Icon(Icons.lock_open),
                    onPressed: () => controller.toggleOcultaSenha(),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Senha obrigatória';
                  } else if (value.length < 6) {
                    return 'Senha precisa ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              );
            }),
            // botão entrar... pra esticar preciso usá-lo em um container
            Container(
              width: double.infinity,
              height: 60,
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                color: ThemeUtils.primaryColor,
                // arredondando os cantos do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: controller.login,
              ),
            ),
            // separador...
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ou',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ThemeUtils.primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            FacebookButton(onTap: () => controller.facebookLogin()),
            FlatButton(
              // onPressed: () => Modular.link.pushNamed('/cadastro'),
              onPressed: () => Modular.to.pushNamed('/login/cadastro'),
              child: Text('Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}
