import 'package:cuidapet_fabreder/app/models/categoria_model.dart';
import 'package:cuidapet_fabreder/app/repository/categoria_repository.dart';

class CategoriaService {
  final CategoriaRepository _repository;

  CategoriaService(this._repository);

  Future<List<CategoriaModel>> buscarCategorias() {
    return _repository.buscarCategorias();
  }
}
