import 'package:flutter_movie/models/movieModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'publicMovieItem.g.dart';

@JsonSerializable()
class PublicMovieItem {
  PublicMovieItem(this.count, this.movies);

  int count;
  List<MovieModel> movies;

  factory PublicMovieItem.fromJson(Map<String, dynamic> json) => _$PublicMovieItemFromJson(json);

  Map<String, dynamic> toJson() => _$PublicMovieItemToJson(this);
}