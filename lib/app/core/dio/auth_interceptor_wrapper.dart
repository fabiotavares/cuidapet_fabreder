import 'package:cuidapet_fabreder/app/repository/shared_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthInterceptorWrapper extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    // antes de enviar a requisição, insere dados de autenticação
    final prefs = await SharedPrefsRepository.instance;
    options.headers['Authorization'] = prefs.accessToken;

    if (DotEnv().env['profile'] == 'dev') {
      print('############### Request log ############### ');
      print('url ${options.uri}');
      print('method ${options.method}');
      print('data ${options.data}');
      print('headers ${options.headers}');
    }
  }

  @override
  Future onResponse(Response response) async {
    print('############### Response log ############### ');
    print('data ${response.data}');
  }

  @override
  Future onError(DioError err) async {
    print('############### Error log ############### ');
    print('error: ${err.response}');
    // Verifica se deu erro 403 ou 401 fazer o refresh do token

    return err;
  }
}
