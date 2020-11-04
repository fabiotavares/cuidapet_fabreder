import 'package:cuidapet_fabreder/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends ModularState<CadastroPage, CadastroController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Usuário'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
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
                } else if (!value.contains('@')) {
                  return 'Login precisa ser um email';
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
            SizedBox(
              height: 20,
            ),

            // confirmar senha...
            Observer(builder: (_) {
              return TextFormField(
                controller: controller.confirmaSenhaController,
                obscureText: controller.ocultaConfirmaSenha,
                decoration: InputDecoration(
                  labelText: 'Confirma Senha',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    gapPadding: 0, // estaço na borda
                  ),
                  suffixIcon: IconButton(
                    icon: controller.ocultaConfirmaSenha ? Icon(Icons.lock) : Icon(Icons.lock_open),
                    onPressed: () => controller.toggleOcultaConfirmaSenha(),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Confirma senha obrigatória';
                  } else if (value.length < 6) {
                    return 'Confirma senha precisa ter pelo menos 6 caracteres';
                  } else if (value != controller.senhaController.text) {
                    return 'Senha e confirma senha não são iguais';
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
                  'Cadastrar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: controller.cadastrarUsuario,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
