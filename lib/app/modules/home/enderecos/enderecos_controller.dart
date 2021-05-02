import 'package:cuidapet_fabreder/app/models/endereco_model.dart';
import 'package:cuidapet_fabreder/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_fabreder/app/services/endereco_service.dart';
import 'package:cuidapet_fabreder/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'enderecos_controller.g.dart';

@Injectable()
class EnderecosController = _EnderecosControllerBase with _$EnderecosController;

abstract class _EnderecosControllerBase with Store {
  // forma de trabalhar com foco num campo de texto
  FocusNode enderecoFocusNode = FocusNode();
  final EnderecoService _enderecoService;
  var enderecoTextController = TextEditingController();

  _EnderecosControllerBase(this._enderecoService);

  @observable
  ObservableFuture<List<EnderecoModel>> enderecosFuture;

  @action
  Future<List<Prediction>> buscarEnderecos(String endereco) async {
    return await _enderecoService.buscarEnderecosGooglePlaces(endereco);
  }

  @action
  Future<void> enviarDetalhe(Prediction pred) async {
    if (pred != null) {
      Loader.show();
      final resultado = await _enderecoService.buscarDetalheEnderecoGooglePlaces(pred.placeId);
      final detalhe = resultado.result;
      var enderecoModel = EnderecoModel(
        id: null,
        endereco: detalhe.formattedAddress,
        latitude: detalhe.geometry.location.lat,
        longitude: detalhe.geometry.location.lng,
        complemento: null,
      );
      Loader.hide();
      // chamar a tela de detalhes ESPERANDO seu retorno (mesmo endereço retornado para edição (possivelmente))...
      var enderecoEdicao =
          await Modular.to.pushNamed('/home/enderecos/detalhe', arguments: enderecoModel) as EnderecoModel;
      verificaEdicaoEndereco(enderecoEdicao);
    }
  }

  @action
  Future<void> minhaLocalizacao() async {
    Loader.show();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: 'pt_BR');

    if (placemarks != null && placemarks.length > 0) {
      var place = placemarks[0];
      var enderecoModel = EnderecoModel(
        id: null,
        endereco: '${place.street}, ${place.locality} - ${place.administrativeArea}, CEP ${place.postalCode}',
        latitude: position.latitude,
        longitude: position.longitude,
        complemento: null,
      );
      Loader.hide();
      // chamar a tela de detalhes ESPERANDO seu retorno aqui...
      var enderecoEdicao =
          await Modular.to.pushNamed('/home/enderecos/detalhe', arguments: enderecoModel) as EnderecoModel;
      verificaEdicaoEndereco(enderecoEdicao);
    } else {
      Loader.hide();
    }
  }

  @action
  void verificaEdicaoEndereco(EnderecoModel enderecoEdicao) {
    if (enderecoEdicao == null) {
      // não quer editar pois já salvou...
      // atualizar a exibição dos endereços...
      buscarEnderecosCadastrados();
      enderecoTextController.clear();
      // tirando o foco através de FocusNode (nó de foco!!)
      enderecoFocusNode.unfocus();
    } else {
      // deseja continuar editando o endereço
      enderecoTextController.text = enderecoEdicao.endereco;
      // cuidado do foco através de FocusNode (nó de foco!!)
      enderecoFocusNode.requestFocus();
    }
  }

  @action
  void buscarEnderecosCadastrados() {
    // uma forma alternativa de fazer sem usar await...
    enderecosFuture = ObservableFuture(_enderecoService.buscarEnderecosCadastrados());
  }

  @action
  Future<void> selecionarEndereco(EnderecoModel model) async {
    // selecionar gravando no sharedpreferences
    var prefs = await SharedPrefsRepository.instance;
    await prefs.registerEnderecoSelecionado(model);
    // depois de registrar o endereço de trabalho, voltar pra home aplicando um pop
    Modular.to.pop();
  }

  Future<bool> enderecoFoiSelecionado() async {
    var prefs = await SharedPrefsRepository.instance;
    return prefs.enderecoSelecionado != null;
  }
}
