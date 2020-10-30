// código gerado pelo jsc e jsf (plugin: flutter helpers)
import 'package:json_annotation/json_annotation.dart';

part 'access_token_model.g.dart';

@JsonSerializable()
class AccessTokenModel {
  // modelo para armazenar o token de autenticação do usuário

  // anotação para relacionar as diferentes formas do nome do atributo,
  // tanto na resposta do rest (map) e como nesta classe de modelo
  @JsonKey(name: 'access_token')
  String accessToken;

  AccessTokenModel(
    this.accessToken,
  );

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenModelToJson(this);
}
