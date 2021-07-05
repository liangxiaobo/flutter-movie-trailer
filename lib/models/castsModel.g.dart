// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'castsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastsModel _$CastsModelFromJson(Map<String, dynamic> json) {
  return CastsModel(
    json['name'] as String,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$CastsModelToJson(CastsModel instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'name': instance.name,
    };
