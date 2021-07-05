// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movieModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return MovieModel(
    json['id'] as String,
    json['author'] as String,
    (json['movieTypes'] as List<dynamic>)
        .map((e) => MoiveTypesModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['casts'] as List<dynamic>)
        .map((e) => CastsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['cover'] as String,
    json['duration'] as String,
    json['isPlay'] as String,
    json['poster'] as String,
    json['pubdate'] as String,
    json['rate'] as String,
    json['summary'] as String,
    json['title'] as String,
    json['video'] as String,
    json['viewCount'] as int,
  );
}

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'cover': instance.cover,
      'duration': instance.duration,
      'isPlay': instance.isPlay,
      'poster': instance.poster,
      'pubdate': instance.pubdate,
      'rate': instance.rate,
      'summary': instance.summary,
      'title': instance.title,
      'video': instance.video,
      'viewCount': instance.viewCount,
      'movieTypes': instance.movieTypes,
      'casts': instance.casts,
    };
