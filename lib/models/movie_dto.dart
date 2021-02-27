library movie_dto;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:movie_client_app/models/serializers.dart';

part 'movie_dto.g.dart';

abstract class MovieDto implements Built<MovieDto, MovieDtoBuilder> {
  MovieDto._();

  factory MovieDto([updates(MovieDtoBuilder b)]) = _$MovieDto;

  @BuiltValueField(wireName: 'adult')
  bool get adult;
  @nullable
  @BuiltValueField(wireName: 'backdrop_path')
  String get backdropPath;
  @BuiltValueField(wireName: 'genre_ids')
  BuiltList<int> get genreIds;
  @BuiltValueField(wireName: 'id')
  int get id;
  @BuiltValueField(wireName: 'original_language')
  String get originalLanguage;
  @BuiltValueField(wireName: 'original_title')
  String get originalTitle;
  @BuiltValueField(wireName: 'overview')
  String get overview;
  @BuiltValueField(wireName: 'popularity')
  double get popularity;
  @nullable
  @BuiltValueField(wireName: 'poster_path')
  String get posterPath;
  @BuiltValueField(wireName: 'release_date')
  String get releaseDate;
  @BuiltValueField(wireName: 'title')
  String get title;
  @BuiltValueField(wireName: 'video')
  bool get video;
  @BuiltValueField(wireName: 'vote_average')
  double get voteAverage;
  @BuiltValueField(wireName: 'vote_count')
  int get voteCount;
  String toJson() {
    return json.encode(serializers.serializeWith(MovieDto.serializer, this));
  }

  static MovieDto fromJson(String jsonString) {
    return serializers.deserializeWith(
        MovieDto.serializer, json.decode(jsonString));
  }

  static Serializer<MovieDto> get serializer => _$movieDtoSerializer;
}
