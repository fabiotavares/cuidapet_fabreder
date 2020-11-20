import 'package:cuidapet_fabreder/app/models/endereco_model.dart';
import 'package:cuidapet_fabreder/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet_fabreder/app/repository/fornecedor_repository.dart';

class FornecedorService {
  final FornecedorRepository _repository;

  FornecedorService(this._repository);

  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(EnderecoModel endereco) {
    return _repository.buscarFornecedoresProximos(endereco.latitude, endereco.longitude);
  }
}
