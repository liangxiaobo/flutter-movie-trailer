
import 'package:flutter_movie/models/castsModel.dart';
import 'package:flutter_movie/models/moiveTypesModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movieModel.g.dart';

@JsonSerializable()
class MovieModel {
  MovieModel(this.id,
      this.author,
      this.movieTypes,
      this.casts,
      this.cover,
      this.duration,
      this.isPlay,
      this.poster,
      this.pubdate,
      this.rate,
      this.summary,
      this.title,
      this.video,
      this.viewCount
      );

  String id;
  String author;
  String cover;
  String duration;
  String isPlay;
  String poster;
  String pubdate;
  String rate;
  String summary;
  String title;
  String video;
  int viewCount;
  List<MoiveTypesModel> movieTypes;
  List<CastsModel> casts;

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}