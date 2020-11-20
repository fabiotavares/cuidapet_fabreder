import 'package:cuidapet_fabreder/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet_fabreder/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';

class EstabelecimentoItemGrid extends StatelessWidget {
  final FornecedorBuscaModel _fornecedor;

  const EstabelecimentoItemGrid(this._fornecedor, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.only(top: 40, left: 10, right: 10),
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: double.infinity,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_fornecedor.nome, style: ThemeUtils.theme.textTheme.subtitle2),
                  SizedBox(height: 10),
                  Text('${_fornecedor.distancia.toStringAsFixed(2)} km de distância'),
                ],
              ),
            ),
          ),
        ),
        // segundo item da stack...
        // bola cinza de trás...
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
            ),
          ),
        ),
        // bola branca da frente...
        Positioned(
          top: 4,
          left: 0,
          right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(_fornecedor.logo),
            ),
          ),
        ),
      ],
    );
  }
}
