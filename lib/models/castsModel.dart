import 'package:json_annotation/json_annotation.dart';
part 'castsModel.g.dart';

@JsonSerializable()
class CastsModel {
  CastsModel(this.name, this.avatar);

  String avatar;
  String name;

  factory CastsModel.fromJson(Map<String, dynamic> json) => _$CastsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CastsModelToJson(this);
}