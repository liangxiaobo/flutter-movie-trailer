import 'package:json_annotation/json_annotation.dart';
part 'moiveTypesModel.g.dart';

@JsonSerializable()
class MoiveTypesModel {
  MoiveTypesModel(this.id, this.name);

  int id;
  String name;

  factory MoiveTypesModel.fromJson(Map<String, dynamic> json) => _$MoiveTypesModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoiveTypesModelToJson(this);
}