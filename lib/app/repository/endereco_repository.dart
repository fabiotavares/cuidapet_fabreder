import 'package:cuidapet_fabreder/app/core/database/connection.dart';
import 'package:cuidapet_fabreder/app/models/endereco_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecoRepository {
  // busca de todos os endereços do banco de dados
  Future<List<EnderecoModel>> buscarEnderecos() async {
    final conn = await Connection().instance;
    final result = await conn.rawQuery('select * from endereco');

    return result.map((e) => EnderecoModel.fromMap(e)).toList();
  }

  // salvar um endereço no banco de dados
  Future<void> salvarEndereco(EnderecoModel model) async {
    final conn = await Connection().instance;
    await conn.rawInsert('insert into endereco values(?, ?, ?, ?, ?)', [
      null,
      model.endereco,
      model.latitude,
      model.longitude,
      model.complemento,
    ]);
  }

  // limpar endereços toda vez que o usuário deslogar
  Future<void> limparEnderecosCadastrados() async {
    final conn = await Connection().instance;
    //sqlite permite fazer sem o where (perigoso)
    await conn.rawDelete('delete from endereco');
  }

  // usando a lib google_maps_webservice para buscar endereços na api places do Google
  Future<List<Prediction>> buscarEnderecosGooglePlaces(String endereco) async {
    final places = GoogleMapsPlaces(apiKey: DotEnv().env['google_api_key']);
    final response = await places.autocomplete(endereco, language: 'pt');
    return response.predictions;
  }

  // obtendo detalhes do prediction
  Future<PlacesDetailsResponse> recuperaDetalhesEnderecoGooglePlaces(String placeId) {
    final places = GoogleMapsPlaces(apiKey: DotEnv().env['google_api_key']);
    return places.getDetailsByPlaceId(placeId);
  }
}
