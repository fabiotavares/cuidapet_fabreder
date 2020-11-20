import 'package:cuidapet_fabreder/app/core/dio/custom_dio.dart';
import 'package:cuidapet_fabreder/app/models/categoria_model.dart';

class CategoriaRepository {
  // método para buscar as categorais no backend
  Future<List<CategoriaModel>> buscarCategorias() async {
    // lembrando que CustomDio já tem a url base
    final res = await CustomDio.authInstance.get('/categorias');
    // por res.data ser dynamic, precisa impor .map e .toList()
    return res.data.map<CategoriaModel>((c) => CategoriaModel.fromJson(c)).toList();
  }
}
