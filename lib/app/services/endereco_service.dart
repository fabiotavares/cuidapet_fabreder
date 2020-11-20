import 'package:cuidapet_fabreder/app/models/endereco_model.dart';
import 'package:cuidapet_fabreder/app/repository/endereco_repository.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecoService {
  final EnderecoRepository _repository;

  EnderecoService(
    this._repository,
  );

  // verifica se existe endereço cadastrado
  Future<bool> existeEnderecoCadastrado() async {
    final listaEnderecos = await _repository.buscarEnderecos();
    return listaEnderecos.isNotEmpty;
  }

  Future<List<Prediction>> buscarEnderecosGooglePlaces(String endereco) async {
    return await _repository.buscarEnderecosGooglePlaces(endereco);
  }

  Future<void> salvarEndereco(EnderecoModel model) async {
    await _repository.salvarEndereco(model);
  }

  Future<List<EnderecoModel>> buscarEnderecosCadastrados() {
    return _repository.buscarEnderecos();
  }

  Future<PlacesDetailsResponse> bucsarDetalheEnderecoGooglePlaces(String placeId) {
    return _repository.recuperaDetalhesEnderecoGooglePlaces(placeId);
  }
}
