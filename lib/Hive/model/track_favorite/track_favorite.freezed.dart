// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track_favorite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrackFavoriteBox _$TrackFavoriteBoxFromJson(Map<String, dynamic> json) {
  return _TrackFavoriteBox.fromJson(json);
}

/// @nodoc
mixin _$TrackFavoriteBox {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  double get size => throw _privateConstructorUsedError;
  @HiveField(2)
  String get track => throw _privateConstructorUsedError;
  @HiveField(3)
  int get bitrate => throw _privateConstructorUsedError;
  @HiveField(4)
  String get duration => throw _privateConstructorUsedError;
  @HiveField(5)
  String get artistName => throw _privateConstructorUsedError;
  @HiveField(6)
  bool get playbackEnabled => throw _privateConstructorUsedError;
  @HiveField(7)
  bool get downloadEnabled => throw _privateConstructorUsedError;
  @HiveField(8)
  String get imageJpg => throw _privateConstructorUsedError;
  @HiveField(9)
  String get imageWebp => throw _privateConstructorUsedError;
  @HiveField(10)
  bool get explicit => throw _privateConstructorUsedError;
  @HiveField(11)
  int get artistId => throw _privateConstructorUsedError;
  @HiveField(12)
  bool get isArtistForeignAgent => throw _privateConstructorUsedError;

  /// Serializes this TrackFavoriteBox to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrackFavoriteBox
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrackFavoriteBoxCopyWith<TrackFavoriteBox> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackFavoriteBoxCopyWith<$Res> {
  factory $TrackFavoriteBoxCopyWith(
          TrackFavoriteBox value, $Res Function(TrackFavoriteBox) then) =
      _$TrackFavoriteBoxCopyWithImpl<$Res, TrackFavoriteBox>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) double size,
      @HiveField(2) String track,
      @HiveField(3) int bitrate,
      @HiveField(4) String duration,
      @HiveField(5) String artistName,
      @HiveField(6) bool playbackEnabled,
      @HiveField(7) bool downloadEnabled,
      @HiveField(8) String imageJpg,
      @HiveField(9) String imageWebp,
      @HiveField(10) bool explicit,
      @HiveField(11) int artistId,
      @HiveField(12) bool isArtistForeignAgent});
}

/// @nodoc
class _$TrackFavoriteBoxCopyWithImpl<$Res, $Val extends TrackFavoriteBox>
    implements $TrackFavoriteBoxCopyWith<$Res> {
  _$TrackFavoriteBoxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrackFavoriteBox
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? size = null,
    Object? track = null,
    Object? bitrate = null,
    Object? duration = null,
    Object? artistName = null,
    Object? playbackEnabled = null,
    Object? downloadEnabled = null,
    Object? imageJpg = null,
    Object? imageWebp = null,
    Object? explicit = null,
    Object? artistId = null,
    Object? isArtistForeignAgent = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double,
      track: null == track
          ? _value.track
          : track // ignore: cast_nullable_to_non_nullable
              as String,
      bitrate: null == bitrate
          ? _value.bitrate
          : bitrate // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      artistName: null == artistName
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String,
      playbackEnabled: null == playbackEnabled
          ? _value.playbackEnabled
          : playbackEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      downloadEnabled: null == downloadEnabled
          ? _value.downloadEnabled
          : downloadEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      imageJpg: null == imageJpg
          ? _value.imageJpg
          : imageJpg // ignore: cast_nullable_to_non_nullable
              as String,
      imageWebp: null == imageWebp
          ? _value.imageWebp
          : imageWebp // ignore: cast_nullable_to_non_nullable
              as String,
      explicit: null == explicit
          ? _value.explicit
          : explicit // ignore: cast_nullable_to_non_nullable
              as bool,
      artistId: null == artistId
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as int,
      isArtistForeignAgent: null == isArtistForeignAgent
          ? _value.isArtistForeignAgent
          : isArtistForeignAgent // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackFavoriteBoxImplCopyWith<$Res>
    implements $TrackFavoriteBoxCopyWith<$Res> {
  factory _$$TrackFavoriteBoxImplCopyWith(_$TrackFavoriteBoxImpl value,
          $Res Function(_$TrackFavoriteBoxImpl) then) =
      __$$TrackFavoriteBoxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) double size,
      @HiveField(2) String track,
      @HiveField(3) int bitrate,
      @HiveField(4) String duration,
      @HiveField(5) String artistName,
      @HiveField(6) bool playbackEnabled,
      @HiveField(7) bool downloadEnabled,
      @HiveField(8) String imageJpg,
      @HiveField(9) String imageWebp,
      @HiveField(10) bool explicit,
      @HiveField(11) int artistId,
      @HiveField(12) bool isArtistForeignAgent});
}

/// @nodoc
class __$$TrackFavoriteBoxImplCopyWithImpl<$Res>
    extends _$TrackFavoriteBoxCopyWithImpl<$Res, _$TrackFavoriteBoxImpl>
    implements _$$TrackFavoriteBoxImplCopyWith<$Res> {
  __$$TrackFavoriteBoxImplCopyWithImpl(_$TrackFavoriteBoxImpl _value,
      $Res Function(_$TrackFavoriteBoxImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrackFavoriteBox
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? size = null,
    Object? track = null,
    Object? bitrate = null,
    Object? duration = null,
    Object? artistName = null,
    Object? playbackEnabled = null,
    Object? downloadEnabled = null,
    Object? imageJpg = null,
    Object? imageWebp = null,
    Object? explicit = null,
    Object? artistId = null,
    Object? isArtistForeignAgent = null,
  }) {
    return _then(_$TrackFavoriteBoxImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double,
      track: null == track
          ? _value.track
          : track // ignore: cast_nullable_to_non_nullable
              as String,
      bitrate: null == bitrate
          ? _value.bitrate
          : bitrate // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      artistName: null == artistName
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String,
      playbackEnabled: null == playbackEnabled
          ? _value.playbackEnabled
          : playbackEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      downloadEnabled: null == downloadEnabled
          ? _value.downloadEnabled
          : downloadEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      imageJpg: null == imageJpg
          ? _value.imageJpg
          : imageJpg // ignore: cast_nullable_to_non_nullable
              as String,
      imageWebp: null == imageWebp
          ? _value.imageWebp
          : imageWebp // ignore: cast_nullable_to_non_nullable
              as String,
      explicit: null == explicit
          ? _value.explicit
          : explicit // ignore: cast_nullable_to_non_nullable
              as bool,
      artistId: null == artistId
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as int,
      isArtistForeignAgent: null == isArtistForeignAgent
          ? _value.isArtistForeignAgent
          : isArtistForeignAgent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackFavoriteBoxImpl implements _TrackFavoriteBox {
  const _$TrackFavoriteBoxImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.size,
      @HiveField(2) required this.track,
      @HiveField(3) required this.bitrate,
      @HiveField(4) required this.duration,
      @HiveField(5) required this.artistName,
      @HiveField(6) required this.playbackEnabled,
      @HiveField(7) required this.downloadEnabled,
      @HiveField(8) required this.imageJpg,
      @HiveField(9) required this.imageWebp,
      @HiveField(10) required this.explicit,
      @HiveField(11) required this.artistId,
      @HiveField(12) required this.isArtistForeignAgent});

  factory _$TrackFavoriteBoxImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackFavoriteBoxImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final double size;
  @override
  @HiveField(2)
  final String track;
  @override
  @HiveField(3)
  final int bitrate;
  @override
  @HiveField(4)
  final String duration;
  @override
  @HiveField(5)
  final String artistName;
  @override
  @HiveField(6)
  final bool playbackEnabled;
  @override
  @HiveField(7)
  final bool downloadEnabled;
  @override
  @HiveField(8)
  final String imageJpg;
  @override
  @HiveField(9)
  final String imageWebp;
  @override
  @HiveField(10)
  final bool explicit;
  @override
  @HiveField(11)
  final int artistId;
  @override
  @HiveField(12)
  final bool isArtistForeignAgent;

  @override
  String toString() {
    return 'TrackFavoriteBox(id: $id, size: $size, track: $track, bitrate: $bitrate, duration: $duration, artistName: $artistName, playbackEnabled: $playbackEnabled, downloadEnabled: $downloadEnabled, imageJpg: $imageJpg, imageWebp: $imageWebp, explicit: $explicit, artistId: $artistId, isArtistForeignAgent: $isArtistForeignAgent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackFavoriteBoxImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.track, track) || other.track == track) &&
            (identical(other.bitrate, bitrate) || other.bitrate == bitrate) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.artistName, artistName) ||
                other.artistName == artistName) &&
            (identical(other.playbackEnabled, playbackEnabled) ||
                other.playbackEnabled == playbackEnabled) &&
            (identical(other.downloadEnabled, downloadEnabled) ||
                other.downloadEnabled == downloadEnabled) &&
            (identical(other.imageJpg, imageJpg) ||
                other.imageJpg == imageJpg) &&
            (identical(other.imageWebp, imageWebp) ||
                other.imageWebp == imageWebp) &&
            (identical(other.explicit, explicit) ||
                other.explicit == explicit) &&
            (identical(other.artistId, artistId) ||
                other.artistId == artistId) &&
            (identical(other.isArtistForeignAgent, isArtistForeignAgent) ||
                other.isArtistForeignAgent == isArtistForeignAgent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      size,
      track,
      bitrate,
      duration,
      artistName,
      playbackEnabled,
      downloadEnabled,
      imageJpg,
      imageWebp,
      explicit,
      artistId,
      isArtistForeignAgent);

  /// Create a copy of TrackFavoriteBox
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackFavoriteBoxImplCopyWith<_$TrackFavoriteBoxImpl> get copyWith =>
      __$$TrackFavoriteBoxImplCopyWithImpl<_$TrackFavoriteBoxImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackFavoriteBoxImplToJson(
      this,
    );
  }
}

abstract class _TrackFavoriteBox implements TrackFavoriteBox {
  const factory _TrackFavoriteBox(
          {@HiveField(0) required final String id,
          @HiveField(1) required final double size,
          @HiveField(2) required final String track,
          @HiveField(3) required final int bitrate,
          @HiveField(4) required final String duration,
          @HiveField(5) required final String artistName,
          @HiveField(6) required final bool playbackEnabled,
          @HiveField(7) required final bool downloadEnabled,
          @HiveField(8) required final String imageJpg,
          @HiveField(9) required final String imageWebp,
          @HiveField(10) required final bool explicit,
          @HiveField(11) required final int artistId,
          @HiveField(12) required final bool isArtistForeignAgent}) =
      _$TrackFavoriteBoxImpl;

  factory _TrackFavoriteBox.fromJson(Map<String, dynamic> json) =
      _$TrackFavoriteBoxImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  double get size;
  @override
  @HiveField(2)
  String get track;
  @override
  @HiveField(3)
  int get bitrate;
  @override
  @HiveField(4)
  String get duration;
  @override
  @HiveField(5)
  String get artistName;
  @override
  @HiveField(6)
  bool get playbackEnabled;
  @override
  @HiveField(7)
  bool get downloadEnabled;
  @override
  @HiveField(8)
  String get imageJpg;
  @override
  @HiveField(9)
  String get imageWebp;
  @override
  @HiveField(10)
  bool get explicit;
  @override
  @HiveField(11)
  int get artistId;
  @override
  @HiveField(12)
  bool get isArtistForeignAgent;

  /// Create a copy of TrackFavoriteBox
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrackFavoriteBoxImplCopyWith<_$TrackFavoriteBoxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
