// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movieDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailModel _$MovieDetailModelFromJson(Map<String, dynamic> json) {
  return MovieDetailModel(
    MovieModel.fromJson(json['movie'] as Map<String, dynamic>),
    (json['relativeMovies'] as List<dynamic>)
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MovieDetailModelToJson(MovieDetailModel instance) =>
    <String, dynamic>{
      'movie': instance.movie,
      'relativeMovies': instance.relativeMovies,
    };
