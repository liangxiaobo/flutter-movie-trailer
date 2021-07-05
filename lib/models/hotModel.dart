import 'package:flutter_movie/models/publicMovieItem.dart';
import 'package:json_annotation/json_annotation.dart';
part 'hotModel.g.dart';

@JsonSerializable()
class HotModel {
  HotModel(this.comming, this.playing);

  PublicMovieItem comming;
  PublicMovieItem playing;

  factory HotModel.fromJson(Map<String, dynamic> json) => _$HotModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotModelToJson(this);

}