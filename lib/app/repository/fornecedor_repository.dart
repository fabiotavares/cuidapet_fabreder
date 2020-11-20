import 'package:cuidapet_fabreder/app/core/dio/custom_dio.dart';
import 'package:cuidapet_fabreder/app/models/fornecedor_busca_model.dart';

class FornecedorRepository {
  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(double lat, double lng) async {
    // // uma forma de fazer...
    // final response = await CustomDio.authInstance.get('/fornecedores', queryParameters: {
    //   'lat': lat,
    //   'long': lng,
    // });

    // return response.data.map<FornecedorBuscaModel>((f) => FornecedorBuscaModel.fromJson(f)).toList();

    // como foi feito no app
    return CustomDio.authInstance.get('/fornecedores', queryParameters: {
      'lat': lat,
      'long': lng,
    }).then((res) => res.data.map<FornecedorBuscaModel>((f) => FornecedorBuscaModel.fromJson(f)).toList());
  }
}
