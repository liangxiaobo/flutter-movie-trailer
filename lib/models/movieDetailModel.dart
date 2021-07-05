import 'package:flutter_movie/models/movieModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movieDetailModel.g.dart';

@JsonSerializable()
class MovieDetailModel {
  MovieDetailModel(this.movie, this.relativeMovies);

  MovieModel movie;
  List<MovieModel> relativeMovies;

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) => _$MovieDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailModelToJson(this);
}