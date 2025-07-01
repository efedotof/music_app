// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'music_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MusicState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Tracks> tracks) tracksScreen,
    required TResult Function(String error) error,
    required TResult Function(List<Playlist> playlists) playListScreen,
    required TResult Function(List<Tracks> traks, List<Playlist> playlists)
        globalScreen,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Tracks> tracks)? tracksScreen,
    TResult? Function(String error)? error,
    TResult? Function(List<Playlist> playlists)? playListScreen,
    TResult? Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Tracks> tracks)? tracksScreen,
    TResult Function(String error)? error,
    TResult Function(List<Playlist> playlists)? playListScreen,
    TResult Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) tracksScreen,
    required TResult Function(_Error value) error,
    required TResult Function(_PlayListScreen value) playListScreen,
    required TResult Function(_GlobalScreen value) globalScreen,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? tracksScreen,
    TResult? Function(_Error value)? error,
    TResult? Function(_PlayListScreen value)? playListScreen,
    TResult? Function(_GlobalScreen value)? globalScreen,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? tracksScreen,
    TResult Function(_Error value)? error,
    TResult Function(_PlayListScreen value)? playListScreen,
    TResult Function(_GlobalScreen value)? globalScreen,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MusicStateCopyWith<$Res> {
  factory $MusicStateCopyWith(
          MusicState value, $Res Function(MusicState) then) =
      _$MusicStateCopyWithImpl<$Res, MusicState>;
}

/// @nodoc
class _$MusicStateCopyWithImpl<$Res, $Val extends MusicState>
    implements $MusicStateCopyWith<$Res> {
  _$MusicStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$MusicStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'MusicState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Tracks> tracks) tracksScreen,
    required TResult Function(String error) error,
    required TResult Function(List<Playlist> playlists) playListScreen,
    required TResult Function(List<Tracks> traks, List<Playlist> playlists)
        globalScreen,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Tracks> tracks)? tracksScreen,
    TResult? Function(String error)? error,
    TResult? Function(List<Playlist> playlists)? playListScreen,
    TResult? Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Tracks> tracks)? tracksScreen,
    TResult Function(String error)? error,
    TResult Function(List<Playlist> playlists)? playListScreen,
    TResult Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) tracksScreen,
    required TResult Function(_Error value) error,
    required TResult Function(_PlayListScreen value) playListScreen,
    required TResult Function(_GlobalScreen value) globalScreen,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? tracksScreen,
    TResult? Function(_Error value)? error,
    TResult? Function(_PlayListScreen value)? playListScreen,
    TResult? Function(_GlobalScreen value)? globalScreen,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? tracksScreen,
    TResult Function(_Error value)? error,
    TResult Function(_PlayListScreen value)? playListScreen,
    TResult Function(_GlobalScreen value)? globalScreen,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements MusicState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$MusicStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'MusicState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Tracks> tracks) tracksScreen,
    required TResult Function(String error) error,
    required TResult Function(List<Playlist> playlists) playListScreen,
    required TResult Function(List<Tracks> traks, List<Playlist> playlists)
        globalScreen,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Tracks> tracks)? tracksScreen,
    TResult? Function(String error)? error,
    TResult? Function(List<Playlist> playlists)? playListScreen,
    TResult? Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Tracks> tracks)? tracksScreen,
    TResult Function(String error)? error,
    TResult Function(List<Playlist> playlists)? playListScreen,
    TResult Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) tracksScreen,
    required TResult Function(_Error value) error,
    required TResult Function(_PlayListScreen value) playListScreen,
    required TResult Function(_GlobalScreen value) globalScreen,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? tracksScreen,
    TResult? Function(_Error value)? error,
    TResult? Function(_PlayListScreen value)? playListScreen,
    TResult? Function(_GlobalScreen value)? globalScreen,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? tracksScreen,
    TResult Function(_Error value)? error,
    TResult Function(_PlayListScreen value)? playListScreen,
    TResult Function(_GlobalScreen value)? globalScreen,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements MusicState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Tracks> tracks});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$MusicStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tracks = null,
  }) {
    return _then(_$LoadedImpl(
      tracks: null == tracks
          ? _value._tracks
          : tracks // ignore: cast_nullable_to_non_nullable
              as List<Tracks>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({required final List<Tracks> tracks}) : _tracks = tracks;

  final List<Tracks> _tracks;
  @override
  List<Tracks> get tracks {
    if (_tracks is EqualUnmodifiableListView) return _tracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tracks);
  }

  @override
  String toString() {
    return 'MusicState.tracksScreen(tracks: $tracks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._tracks, _tracks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tracks));

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Tracks> tracks) tracksScreen,
    required TResult Function(String error) error,
    required TResult Function(List<Playlist> playlists) playListScreen,
    required TResult Function(List<Tracks> traks, List<Playlist> playlists)
        globalScreen,
  }) {
    return tracksScreen(tracks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Tracks> tracks)? tracksScreen,
    TResult? Function(String error)? error,
    TResult? Function(List<Playlist> playlists)? playListScreen,
    TResult? Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
  }) {
    return tracksScreen?.call(tracks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Tracks> tracks)? tracksScreen,
    TResult Function(String error)? error,
    TResult Function(List<Playlist> playlists)? playListScreen,
    TResult Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
    required TResult orElse(),
  }) {
    if (tracksScreen != null) {
      return tracksScreen(tracks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) tracksScreen,
    required TResult Function(_Error value) error,
    required TResult Function(_PlayListScreen value) playListScreen,
    required TResult Function(_GlobalScreen value) globalScreen,
  }) {
    return tracksScreen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? tracksScreen,
    TResult? Function(_Error value)? error,
    TResult? Function(_PlayListScreen value)? playListScreen,
    TResult? Function(_GlobalScreen value)? globalScreen,
  }) {
    return tracksScreen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? tracksScreen,
    TResult Function(_Error value)? error,
    TResult Function(_PlayListScreen value)? playListScreen,
    TResult Function(_GlobalScreen value)? globalScreen,
    required TResult orElse(),
  }) {
    if (tracksScreen != null) {
      return tracksScreen(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements MusicState {
  const factory _Loaded({required final List<Tracks> tracks}) = _$LoadedImpl;

  List<Tracks> get tracks;

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$MusicStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ErrorImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'MusicState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Tracks> tracks) tracksScreen,
    required TResult Function(String error) error,
    required TResult Function(List<Playlist> playlists) playListScreen,
    required TResult Function(List<Tracks> traks, List<Playlist> playlists)
        globalScreen,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Tracks> tracks)? tracksScreen,
    TResult? Function(String error)? error,
    TResult? Function(List<Playlist> playlists)? playListScreen,
    TResult? Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Tracks> tracks)? tracksScreen,
    TResult Function(String error)? error,
    TResult Function(List<Playlist> playlists)? playListScreen,
    TResult Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) tracksScreen,
    required TResult Function(_Error value) error,
    required TResult Function(_PlayListScreen value) playListScreen,
    required TResult Function(_GlobalScreen value) globalScreen,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? tracksScreen,
    TResult? Function(_Error value)? error,
    TResult? Function(_PlayListScreen value)? playListScreen,
    TResult? Function(_GlobalScreen value)? globalScreen,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? tracksScreen,
    TResult Function(_Error value)? error,
    TResult Function(_PlayListScreen value)? playListScreen,
    TResult Function(_GlobalScreen value)? globalScreen,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements MusicState {
  const factory _Error({required final String error}) = _$ErrorImpl;

  String get error;

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PlayListScreenImplCopyWith<$Res> {
  factory _$$PlayListScreenImplCopyWith(_$PlayListScreenImpl value,
          $Res Function(_$PlayListScreenImpl) then) =
      __$$PlayListScreenImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Playlist> playlists});
}

/// @nodoc
class __$$PlayListScreenImplCopyWithImpl<$Res>
    extends _$MusicStateCopyWithImpl<$Res, _$PlayListScreenImpl>
    implements _$$PlayListScreenImplCopyWith<$Res> {
  __$$PlayListScreenImplCopyWithImpl(
      _$PlayListScreenImpl _value, $Res Function(_$PlayListScreenImpl) _then)
      : super(_value, _then);

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playlists = null,
  }) {
    return _then(_$PlayListScreenImpl(
      playlists: null == playlists
          ? _value._playlists
          : playlists // ignore: cast_nullable_to_non_nullable
              as List<Playlist>,
    ));
  }
}

/// @nodoc

class _$PlayListScreenImpl implements _PlayListScreen {
  const _$PlayListScreenImpl({required final List<Playlist> playlists})
      : _playlists = playlists;

  final List<Playlist> _playlists;
  @override
  List<Playlist> get playlists {
    if (_playlists is EqualUnmodifiableListView) return _playlists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playlists);
  }

  @override
  String toString() {
    return 'MusicState.playListScreen(playlists: $playlists)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayListScreenImpl &&
            const DeepCollectionEquality()
                .equals(other._playlists, _playlists));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_playlists));

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayListScreenImplCopyWith<_$PlayListScreenImpl> get copyWith =>
      __$$PlayListScreenImplCopyWithImpl<_$PlayListScreenImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Tracks> tracks) tracksScreen,
    required TResult Function(String error) error,
    required TResult Function(List<Playlist> playlists) playListScreen,
    required TResult Function(List<Tracks> traks, List<Playlist> playlists)
        globalScreen,
  }) {
    return playListScreen(playlists);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Tracks> tracks)? tracksScreen,
    TResult? Function(String error)? error,
    TResult? Function(List<Playlist> playlists)? playListScreen,
    TResult? Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
  }) {
    return playListScreen?.call(playlists);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Tracks> tracks)? tracksScreen,
    TResult Function(String error)? error,
    TResult Function(List<Playlist> playlists)? playListScreen,
    TResult Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
    required TResult orElse(),
  }) {
    if (playListScreen != null) {
      return playListScreen(playlists);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) tracksScreen,
    required TResult Function(_Error value) error,
    required TResult Function(_PlayListScreen value) playListScreen,
    required TResult Function(_GlobalScreen value) globalScreen,
  }) {
    return playListScreen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? tracksScreen,
    TResult? Function(_Error value)? error,
    TResult? Function(_PlayListScreen value)? playListScreen,
    TResult? Function(_GlobalScreen value)? globalScreen,
  }) {
    return playListScreen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? tracksScreen,
    TResult Function(_Error value)? error,
    TResult Function(_PlayListScreen value)? playListScreen,
    TResult Function(_GlobalScreen value)? globalScreen,
    required TResult orElse(),
  }) {
    if (playListScreen != null) {
      return playListScreen(this);
    }
    return orElse();
  }
}

abstract class _PlayListScreen implements MusicState {
  const factory _PlayListScreen({required final List<Playlist> playlists}) =
      _$PlayListScreenImpl;

  List<Playlist> get playlists;

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayListScreenImplCopyWith<_$PlayListScreenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GlobalScreenImplCopyWith<$Res> {
  factory _$$GlobalScreenImplCopyWith(
          _$GlobalScreenImpl value, $Res Function(_$GlobalScreenImpl) then) =
      __$$GlobalScreenImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Tracks> traks, List<Playlist> playlists});
}

/// @nodoc
class __$$GlobalScreenImplCopyWithImpl<$Res>
    extends _$MusicStateCopyWithImpl<$Res, _$GlobalScreenImpl>
    implements _$$GlobalScreenImplCopyWith<$Res> {
  __$$GlobalScreenImplCopyWithImpl(
      _$GlobalScreenImpl _value, $Res Function(_$GlobalScreenImpl) _then)
      : super(_value, _then);

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traks = null,
    Object? playlists = null,
  }) {
    return _then(_$GlobalScreenImpl(
      traks: null == traks
          ? _value._traks
          : traks // ignore: cast_nullable_to_non_nullable
              as List<Tracks>,
      playlists: null == playlists
          ? _value._playlists
          : playlists // ignore: cast_nullable_to_non_nullable
              as List<Playlist>,
    ));
  }
}

/// @nodoc

class _$GlobalScreenImpl implements _GlobalScreen {
  const _$GlobalScreenImpl(
      {required final List<Tracks> traks,
      required final List<Playlist> playlists})
      : _traks = traks,
        _playlists = playlists;

  final List<Tracks> _traks;
  @override
  List<Tracks> get traks {
    if (_traks is EqualUnmodifiableListView) return _traks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_traks);
  }

  final List<Playlist> _playlists;
  @override
  List<Playlist> get playlists {
    if (_playlists is EqualUnmodifiableListView) return _playlists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playlists);
  }

  @override
  String toString() {
    return 'MusicState.globalScreen(traks: $traks, playlists: $playlists)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GlobalScreenImpl &&
            const DeepCollectionEquality().equals(other._traks, _traks) &&
            const DeepCollectionEquality()
                .equals(other._playlists, _playlists));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_traks),
      const DeepCollectionEquality().hash(_playlists));

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GlobalScreenImplCopyWith<_$GlobalScreenImpl> get copyWith =>
      __$$GlobalScreenImplCopyWithImpl<_$GlobalScreenImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Tracks> tracks) tracksScreen,
    required TResult Function(String error) error,
    required TResult Function(List<Playlist> playlists) playListScreen,
    required TResult Function(List<Tracks> traks, List<Playlist> playlists)
        globalScreen,
  }) {
    return globalScreen(traks, playlists);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Tracks> tracks)? tracksScreen,
    TResult? Function(String error)? error,
    TResult? Function(List<Playlist> playlists)? playListScreen,
    TResult? Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
  }) {
    return globalScreen?.call(traks, playlists);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Tracks> tracks)? tracksScreen,
    TResult Function(String error)? error,
    TResult Function(List<Playlist> playlists)? playListScreen,
    TResult Function(List<Tracks> traks, List<Playlist> playlists)?
        globalScreen,
    required TResult orElse(),
  }) {
    if (globalScreen != null) {
      return globalScreen(traks, playlists);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) tracksScreen,
    required TResult Function(_Error value) error,
    required TResult Function(_PlayListScreen value) playListScreen,
    required TResult Function(_GlobalScreen value) globalScreen,
  }) {
    return globalScreen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? tracksScreen,
    TResult? Function(_Error value)? error,
    TResult? Function(_PlayListScreen value)? playListScreen,
    TResult? Function(_GlobalScreen value)? globalScreen,
  }) {
    return globalScreen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? tracksScreen,
    TResult Function(_Error value)? error,
    TResult Function(_PlayListScreen value)? playListScreen,
    TResult Function(_GlobalScreen value)? globalScreen,
    required TResult orElse(),
  }) {
    if (globalScreen != null) {
      return globalScreen(this);
    }
    return orElse();
  }
}

abstract class _GlobalScreen implements MusicState {
  const factory _GlobalScreen(
      {required final List<Tracks> traks,
      required final List<Playlist> playlists}) = _$GlobalScreenImpl;

  List<Tracks> get traks;
  List<Playlist> get playlists;

  /// Create a copy of MusicState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GlobalScreenImplCopyWith<_$GlobalScreenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
