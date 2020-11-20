import 'package:cuidapet_fabreder/app/models/endereco_model.dart';
import 'package:cuidapet_fabreder/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'enderecos_controller.dart';

class EnderecosPage extends StatefulWidget {
  const EnderecosPage({Key key}) : super(key: key);

  @override
  _EnderecosPageState createState() => _EnderecosPageState();
}

class _EnderecosPageState extends ModularState<EnderecosPage, EnderecosController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.buscarEnderecosCadastrados();
  }

  @override
  Widget build(BuildContext context) {
    // WillPopScope => onWillPop é chamado antes de sair da tela (se retornar false não deixa sair da tela)
    return WillPopScope(
      onWillPop: () async {
        // só vai permitir sair da tela se o usuário selecionou um endereço
        var selecionouEndereco = await controller.enderecoFoiSelecionado();
        if (selecionouEndereco) {
          return true;
        } else {
          Get.snackbar('Erro', 'Por favor, selecione um endereço!!!');
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text(
                  'Adicione ou escolha um endereço',
                  // copyWith copia todo o padrão e adiciona apenas as alterações desejadas
                  style: ThemeUtils.theme.textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                // pra fazer o sombreado (material - muito bom)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    // uso de uma lib interessante de auto complete
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        focusNode: controller.enderecoFocusNode,
                        controller: controller.enderecoTextController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                          hintText: 'Insira um endereço',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                        ),
                      ),
                      // faz a busca pela API do Google
                      suggestionsCallback: controller.buscarEnderecos,
                      // O retorno da callback acima é injetado em itemData
                      itemBuilder: (BuildContext context, Prediction itemData) {
                        return ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text(itemData.description),
                        );
                      },
                      onSuggestionSelected: (Prediction suggestion) {
                        // copiando a sugestão
                        controller.enderecoTextController.text = suggestion.description;
                        // abrindo tela de detalhes com a sugestão escolhida
                        controller.enviarDetalhe(suggestion);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  // onTap: () => Modular.link.pushNamed('/detalhe'),
                  onTap: () => controller.minhaLocalizacao(),
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                    ),
                    radius: 30, // tamanho do avatar
                    backgroundColor: Colors.red,
                  ),
                  title: Text('Localização Atual'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                SizedBox(height: 10),
                // forma de montar a lista com um futuro
                Observer(builder: (_) {
                  return FutureBuilder<List<EnderecoModel>>(
                    future: controller.enderecosFuture,
                    builder: (context, snapshot) {
                      final data = snapshot.data;

                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Container();
                          break;
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                          break;
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true, // sem isso dá erro (porque está dentro de uma column)
                              itemCount: data.length,
                              itemBuilder: (context, index) => _buildItemEndereco(data[index]),
                            );
                          } else {
                            return Center(
                              child: Text('Nenhum endereço cadastrado'),
                            );
                          }
                          break;
                        default:
                          return Container();
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemEndereco(EnderecoModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () => controller.selecionarEndereco(model),
        leading: CircleAvatar(
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
          radius: 30,
          backgroundColor: Colors.white,
        ),
        title: Text(model.endereco),
        subtitle: Text(model.complemento),
      ),
    );
  }
}
