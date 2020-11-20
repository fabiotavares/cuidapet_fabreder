import 'dart:io';

import 'package:cuidapet_fabreder/app/models/endereco_model.dart';
import 'package:cuidapet_fabreder/app/shared/theme_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'detalhe_controller.dart';

class DetalhePage extends StatefulWidget {
  final EnderecoModel enderecoModel;

  const DetalhePage({
    Key key,
    @required this.enderecoModel,
  }) : super(key: key);

  @override
  _DetalhePageState createState() => _DetalhePageState(enderecoModel);
}

class _DetalhePageState extends ModularState<DetalhePage, DetalheController> {
  //use 'controller' variable to access controller
  final EnderecoModel enderecoModel;

  var appBar = AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
  );

  _DetalhePageState(this.enderecoModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil().screenWidth,
          height: recuperarTamanhoTela(),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Confirme seu endereço',
                // copyWith copia todo o padrão e adiciona apenas as alterações desejadas
                style: ThemeUtils.theme.textTheme.headline5.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(enderecoModel.latitude, enderecoModel.longitude),
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('end'), //qualquer
                      position: LatLng(enderecoModel.latitude, enderecoModel.longitude),
                      infoWindow: InfoWindow(title: enderecoModel.endereco),
                    )
                  },
                  myLocationButtonEnabled: false,
                ),
              ),
              TextFormField(
                initialValue: enderecoModel.endereco,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Modular.to.pop(enderecoModel),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: controller.complementoTextController,
                decoration: InputDecoration(labelText: 'Complemento'),
              ),
              SizedBox(height: 20),
              Container(
                width: ScreenUtil().screenWidth * .9,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    'Salvar',
                    style: TextStyle(fontSize: 20),
                  ),
                  color: ThemeUtils.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: () => controller.salvarEndereco(enderecoModel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double recuperarTamanhoTela() {
    var bottomBar = 0.0; // só tem no ios
    if (Platform.isIOS) {
      bottomBar = ScreenUtil().bottomBarHeight;
    }
    return ScreenUtil().screenHeight - (ScreenUtil().statusBarHeight + appBar.preferredSize.height + bottomBar);
  }
}
