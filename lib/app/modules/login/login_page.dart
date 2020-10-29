import 'package:cuidapet_fabreder/app/shared/components/facebook_button.dart';
import 'package:cuidapet_fabreder/app/shared/theme_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: Container(
        // width: ScreenUtil().screenWidth,
        // height: ScreenUtil().screenHeight,
        child: Stack(
          children: [
            Container(
              // fundo com a imagem de backgroud
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight * .95,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('lib/assets/images/login_background.png'),
                fit: BoxFit.fill,
              )),
            ),
            // logo
            Container(
              // descontando o tamanho da status bar
              margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight + 30),
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
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        child: Column(
          children: [
            // login...
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Login',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  gapPadding: 0, // estaço na borda
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // senha...
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  gapPadding: 0, // estaço na borda
                ),
              ),
            ),
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
                onPressed: () async {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: 'fabreder5@gmail.com', password: '123123');

                  FacebookLogin()
                      .logIn(['public_profile', 'email']).then((value) {
                    print('Status: ${value.status}');
                    print('Erro: ${value.errorMessage}');
                    print('Token: ${value.accessToken}');
                  });
                },
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
            FacebookButton(),
            FlatButton(
              onPressed: () {},
              child: Text('Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}
