// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publicMovieItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicMovieItem _$PublicMovieItemFromJson(Map<String, dynamic> json) {
  return PublicMovieItem(
    json['count'] as int,
    (json['movies'] as List<dynamic>)
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PublicMovieItemToJson(PublicMovieItem instance) =>
    <String, dynamic>{
      'count': instance.count,
      'movies': instance.movies,
    };
