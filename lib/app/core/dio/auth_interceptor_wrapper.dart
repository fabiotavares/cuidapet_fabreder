import 'package:cuidapet_fabreder/app/core/dio/custom_dio.dart';
import 'package:cuidapet_fabreder/app/repository/security_storage_repository.dart';
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
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      await _refreshToken();
      print('############### Access Token Atualizado ############### ');
      final req = err.request;
      // repetindo a requisição anterior com os dados renovados
      // uso de request pois não sei qual requisição foi usada
      return CustomDio.authInstance.request(req.path, options: req);
    }

    return err;
  }

  Future<void> _refreshToken() async {
    final prefs = await SharedPrefsRepository.instance;
    final security = SecurityStorageRepository();
    try {
      final accessToken = prefs.accessToken;
      final refreshToken = await security.refreshToken;

      final refreshResult = await CustomDio.instance.put('/login/refresh', data: {
        'token': accessToken,
        'refresh_token': refreshToken,
      });

      await prefs.registerAccessToken(refreshResult.data['access_token']);
      await security.registerRefreshToken(refreshResult.data['refresh_token']);
    } catch (e) {
      print('Erro no _refreshToken: $e');
      prefs.logout();
    }
  }
}
