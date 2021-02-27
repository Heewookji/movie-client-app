// GENERATED CODE - DO NOT MODIFY BY HAND

part of movie_dto;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MovieDto> _$movieDtoSerializer = new _$MovieDtoSerializer();

class _$MovieDtoSerializer implements StructuredSerializer<MovieDto> {
  @override
  final Iterable<Type> types = const [MovieDto, _$MovieDto];
  @override
  final String wireName = 'MovieDto';

  @override
  Iterable<Object> serialize(Serializers serializers, MovieDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'adult',
      serializers.serialize(object.adult, specifiedType: const FullType(bool)),
      'genre_ids',
      serializers.serialize(object.genreIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'original_language',
      serializers.serialize(object.originalLanguage,
          specifiedType: const FullType(String)),
      'original_title',
      serializers.serialize(object.originalTitle,
          specifiedType: const FullType(String)),
      'overview',
      serializers.serialize(object.overview,
          specifiedType: const FullType(String)),
      'popularity',
      serializers.serialize(object.popularity,
          specifiedType: const FullType(double)),
      'release_date',
      serializers.serialize(object.releaseDate,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'video',
      serializers.serialize(object.video, specifiedType: const FullType(bool)),
      'vote_average',
      serializers.serialize(object.voteAverage,
          specifiedType: const FullType(double)),
      'vote_count',
      serializers.serialize(object.voteCount,
          specifiedType: const FullType(int)),
    ];
    if (object.backdropPath != null) {
      result
        ..add('backdrop_path')
        ..add(serializers.serialize(object.backdropPath,
            specifiedType: const FullType(String)));
    }
    if (object.posterPath != null) {
      result
        ..add('poster_path')
        ..add(serializers.serialize(object.posterPath,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  MovieDto deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MovieDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'adult':
          result.adult = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'backdrop_path':
          result.backdropPath = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'genre_ids':
          result.genreIds.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList<Object>);
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'original_language':
          result.originalLanguage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'original_title':
          result.originalTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'overview':
          result.overview = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'popularity':
          result.popularity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'poster_path':
          result.posterPath = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'release_date':
          result.releaseDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'video':
          result.video = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'vote_average':
          result.voteAverage = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'vote_count':
          result.voteCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$MovieDto extends MovieDto {
  @override
  final bool adult;
  @override
  final String backdropPath;
  @override
  final BuiltList<int> genreIds;
  @override
  final int id;
  @override
  final String originalLanguage;
  @override
  final String originalTitle;
  @override
  final String overview;
  @override
  final double popularity;
  @override
  final String posterPath;
  @override
  final String releaseDate;
  @override
  final String title;
  @override
  final bool video;
  @override
  final double voteAverage;
  @override
  final int voteCount;

  factory _$MovieDto([void Function(MovieDtoBuilder) updates]) =>
      (new MovieDtoBuilder()..update(updates)).build();

  _$MovieDto._(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount})
      : super._() {
    if (adult == null) {
      throw new BuiltValueNullFieldError('MovieDto', 'adult');
    }
    if (genreIds == null) {
      throw new BuiltValueNullFieldError('MovieDto', 'genreIds');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('MovieDto', 'id');
    }
    if (originalLanguage == null) {
      throw new BuiltValueNullFieldError('MovieDto', 'originalLanguage');
    }
    if (originalTitle == null) {
      throw new BuiltValueNullFieldError('MovieDto', 'originalTitle');
    }
    if (overview == null) {
      throw new BuiltValueNullFieldError('MovieDto', 'overview');
    }
    if (popularity == null) {
      throw new BuiltValueNullFieldError('MovieDto', 'popularity');
    }
    if (releaseDate == null) {
      throw new BuiltValueNullFieldError('MovieDto', 'releaseDate');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('MovieDto', 'title');
    }
    if (video == null) {
      throw new BuiltValueNullFieldError('MovieDto', 'video');
    }
    if (voteAverage == null) {
      throw new BuiltValueNullFieldError('MovieDto', 'voteAverage');
    }
    if (voteCount == null) {
      throw new BuiltValueNullFieldError('MovieDto', 'voteCount');
    }
  }

  @override
  MovieDto rebuild(void Function(MovieDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MovieDtoBuilder toBuilder() => new MovieDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MovieDto &&
        adult == other.adult &&
        backdropPath == other.backdropPath &&
        genreIds == other.genreIds &&
        id == other.id &&
        originalLanguage == other.originalLanguage &&
        originalTitle == other.originalTitle &&
        overview == other.overview &&
        popularity == other.popularity &&
        posterPath == other.posterPath &&
        releaseDate == other.releaseDate &&
        title == other.title &&
        video == other.video &&
        voteAverage == other.voteAverage &&
        voteCount == other.voteCount;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc($jc(0, adult.hashCode),
                                                        backdropPath.hashCode),
                                                    genreIds.hashCode),
                                                id.hashCode),
                                            originalLanguage.hashCode),
                                        originalTitle.hashCode),
                                    overview.hashCode),
                                popularity.hashCode),
                            posterPath.hashCode),
                        releaseDate.hashCode),
                    title.hashCode),
                video.hashCode),
            voteAverage.hashCode),
        voteCount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MovieDto')
          ..add('adult', adult)
          ..add('backdropPath', backdropPath)
          ..add('genreIds', genreIds)
          ..add('id', id)
          ..add('originalLanguage', originalLanguage)
          ..add('originalTitle', originalTitle)
          ..add('overview', overview)
          ..add('popularity', popularity)
          ..add('posterPath', posterPath)
          ..add('releaseDate', releaseDate)
          ..add('title', title)
          ..add('video', video)
          ..add('voteAverage', voteAverage)
          ..add('voteCount', voteCount))
        .toString();
  }
}

class MovieDtoBuilder implements Builder<MovieDto, MovieDtoBuilder> {
  _$MovieDto _$v;

  bool _adult;
  bool get adult => _$this._adult;
  set adult(bool adult) => _$this._adult = adult;

  String _backdropPath;
  String get backdropPath => _$this._backdropPath;
  set backdropPath(String backdropPath) => _$this._backdropPath = backdropPath;

  ListBuilder<int> _genreIds;
  ListBuilder<int> get genreIds => _$this._genreIds ??= new ListBuilder<int>();
  set genreIds(ListBuilder<int> genreIds) => _$this._genreIds = genreIds;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _originalLanguage;
  String get originalLanguage => _$this._originalLanguage;
  set originalLanguage(String originalLanguage) =>
      _$this._originalLanguage = originalLanguage;

  String _originalTitle;
  String get originalTitle => _$this._originalTitle;
  set originalTitle(String originalTitle) =>
      _$this._originalTitle = originalTitle;

  String _overview;
  String get overview => _$this._overview;
  set overview(String overview) => _$this._overview = overview;

  double _popularity;
  double get popularity => _$this._popularity;
  set popularity(double popularity) => _$this._popularity = popularity;

  String _posterPath;
  String get posterPath => _$this._posterPath;
  set posterPath(String posterPath) => _$this._posterPath = posterPath;

  String _releaseDate;
  String get releaseDate => _$this._releaseDate;
  set releaseDate(String releaseDate) => _$this._releaseDate = releaseDate;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  bool _video;
  bool get video => _$this._video;
  set video(bool video) => _$this._video = video;

  double _voteAverage;
  double get voteAverage => _$this._voteAverage;
  set voteAverage(double voteAverage) => _$this._voteAverage = voteAverage;

  int _voteCount;
  int get voteCount => _$this._voteCount;
  set voteCount(int voteCount) => _$this._voteCount = voteCount;

  MovieDtoBuilder();

  MovieDtoBuilder get _$this {
    if (_$v != null) {
      _adult = _$v.adult;
      _backdropPath = _$v.backdropPath;
      _genreIds = _$v.genreIds?.toBuilder();
      _id = _$v.id;
      _originalLanguage = _$v.originalLanguage;
      _originalTitle = _$v.originalTitle;
      _overview = _$v.overview;
      _popularity = _$v.popularity;
      _posterPath = _$v.posterPath;
      _releaseDate = _$v.releaseDate;
      _title = _$v.title;
      _video = _$v.video;
      _voteAverage = _$v.voteAverage;
      _voteCount = _$v.voteCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MovieDto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MovieDto;
  }

  @override
  void update(void Function(MovieDtoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MovieDto build() {
    _$MovieDto _$result;
    try {
      _$result = _$v ??
          new _$MovieDto._(
              adult: adult,
              backdropPath: backdropPath,
              genreIds: genreIds.build(),
              id: id,
              originalLanguage: originalLanguage,
              originalTitle: originalTitle,
              overview: overview,
              popularity: popularity,
              posterPath: posterPath,
              releaseDate: releaseDate,
              title: title,
              video: video,
              voteAverage: voteAverage,
              voteCount: voteCount);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'genreIds';
        genreIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MovieDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
