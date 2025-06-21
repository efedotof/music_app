// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlaybackState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function() playing,
    required TResult Function() paused,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function()? playing,
    TResult? Function()? paused,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function()? playing,
    TResult Function()? paused,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Stopped value) stopped,
    required TResult Function(Playing value) playing,
    required TResult Function(Paused value) paused,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Stopped value)? stopped,
    TResult? Function(Playing value)? playing,
    TResult? Function(Paused value)? paused,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Stopped value)? stopped,
    TResult Function(Playing value)? playing,
    TResult Function(Paused value)? paused,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybackStateCopyWith<$Res> {
  factory $PlaybackStateCopyWith(
          PlaybackState value, $Res Function(PlaybackState) then) =
      _$PlaybackStateCopyWithImpl<$Res, PlaybackState>;
}

/// @nodoc
class _$PlaybackStateCopyWithImpl<$Res, $Val extends PlaybackState>
    implements $PlaybackStateCopyWith<$Res> {
  _$PlaybackStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StoppedImplCopyWith<$Res> {
  factory _$$StoppedImplCopyWith(
          _$StoppedImpl value, $Res Function(_$StoppedImpl) then) =
      __$$StoppedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StoppedImplCopyWithImpl<$Res>
    extends _$PlaybackStateCopyWithImpl<$Res, _$StoppedImpl>
    implements _$$StoppedImplCopyWith<$Res> {
  __$$StoppedImplCopyWithImpl(
      _$StoppedImpl _value, $Res Function(_$StoppedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StoppedImpl implements Stopped {
  const _$StoppedImpl();

  @override
  String toString() {
    return 'PlaybackState.stopped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StoppedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function() playing,
    required TResult Function() paused,
  }) {
    return stopped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function()? playing,
    TResult? Function()? paused,
  }) {
    return stopped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function()? playing,
    TResult Function()? paused,
    required TResult orElse(),
  }) {
    if (stopped != null) {
      return stopped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Stopped value) stopped,
    required TResult Function(Playing value) playing,
    required TResult Function(Paused value) paused,
  }) {
    return stopped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Stopped value)? stopped,
    TResult? Function(Playing value)? playing,
    TResult? Function(Paused value)? paused,
  }) {
    return stopped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Stopped value)? stopped,
    TResult Function(Playing value)? playing,
    TResult Function(Paused value)? paused,
    required TResult orElse(),
  }) {
    if (stopped != null) {
      return stopped(this);
    }
    return orElse();
  }
}

abstract class Stopped implements PlaybackState {
  const factory Stopped() = _$StoppedImpl;
}

/// @nodoc
abstract class _$$PlayingImplCopyWith<$Res> {
  factory _$$PlayingImplCopyWith(
          _$PlayingImpl value, $Res Function(_$PlayingImpl) then) =
      __$$PlayingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlayingImplCopyWithImpl<$Res>
    extends _$PlaybackStateCopyWithImpl<$Res, _$PlayingImpl>
    implements _$$PlayingImplCopyWith<$Res> {
  __$$PlayingImplCopyWithImpl(
      _$PlayingImpl _value, $Res Function(_$PlayingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PlayingImpl implements Playing {
  const _$PlayingImpl();

  @override
  String toString() {
    return 'PlaybackState.playing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PlayingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function() playing,
    required TResult Function() paused,
  }) {
    return playing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function()? playing,
    TResult? Function()? paused,
  }) {
    return playing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function()? playing,
    TResult Function()? paused,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Stopped value) stopped,
    required TResult Function(Playing value) playing,
    required TResult Function(Paused value) paused,
  }) {
    return playing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Stopped value)? stopped,
    TResult? Function(Playing value)? playing,
    TResult? Function(Paused value)? paused,
  }) {
    return playing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Stopped value)? stopped,
    TResult Function(Playing value)? playing,
    TResult Function(Paused value)? paused,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(this);
    }
    return orElse();
  }
}

abstract class Playing implements PlaybackState {
  const factory Playing() = _$PlayingImpl;
}

/// @nodoc
abstract class _$$PausedImplCopyWith<$Res> {
  factory _$$PausedImplCopyWith(
          _$PausedImpl value, $Res Function(_$PausedImpl) then) =
      __$$PausedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PausedImplCopyWithImpl<$Res>
    extends _$PlaybackStateCopyWithImpl<$Res, _$PausedImpl>
    implements _$$PausedImplCopyWith<$Res> {
  __$$PausedImplCopyWithImpl(
      _$PausedImpl _value, $Res Function(_$PausedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PausedImpl implements Paused {
  const _$PausedImpl();

  @override
  String toString() {
    return 'PlaybackState.paused()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PausedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function() playing,
    required TResult Function() paused,
  }) {
    return paused();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function()? playing,
    TResult? Function()? paused,
  }) {
    return paused?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function()? playing,
    TResult Function()? paused,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Stopped value) stopped,
    required TResult Function(Playing value) playing,
    required TResult Function(Paused value) paused,
  }) {
    return paused(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Stopped value)? stopped,
    TResult? Function(Playing value)? playing,
    TResult? Function(Paused value)? paused,
  }) {
    return paused?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Stopped value)? stopped,
    TResult Function(Playing value)? playing,
    TResult Function(Paused value)? paused,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused(this);
    }
    return orElse();
  }
}

abstract class Paused implements PlaybackState {
  const factory Paused() = _$PausedImpl;
}
