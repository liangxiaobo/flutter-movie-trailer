// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotModel _$HotModelFromJson(Map<String, dynamic> json) {
  return HotModel(
    PublicMovieItem.fromJson(json['comming'] as Map<String, dynamic>),
    PublicMovieItem.fromJson(json['playing'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HotModelToJson(HotModel instance) => <String, dynamic>{
      'comming': instance.comming,
      'playing': instance.playing,
    };
