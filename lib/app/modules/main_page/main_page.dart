import 'package:cuidapet_fabreder/app/shared/auth_store.dart';
import 'package:cuidapet_fabreder/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatelessWidget {
  MainPage() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // só roda depois que a página é construída
      final authStore = Modular.get<AuthStore>();
      final isLogged = await authStore.isLogged();

      if (isLogged) {
        // serve pra matar esta página e tudo que tinha antes
        Modular.to.pushNamedAndRemoveUntil('/home', (_) => false);
      } else {
        // serve pra matar esta página e tudo que tinha antes
        Modular.to.pushNamedAndRemoveUntil('/login', (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // inicializando o componente ScreenUtil (esse app será 100% retrato)
    ScreenUtil.init(context);
    ThemeUtils.init(context);

    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset('lib/assets/images/logo.png'),
        ),
      ),
    );
  }
}
