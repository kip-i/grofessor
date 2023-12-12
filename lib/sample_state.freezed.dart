// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SampleScreenState {
  Duration get totalDuration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SampleScreenStateCopyWith<SampleScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SampleScreenStateCopyWith<$Res> {
  factory $SampleScreenStateCopyWith(
          SampleScreenState value, $Res Function(SampleScreenState) then) =
      _$SampleScreenStateCopyWithImpl<$Res, SampleScreenState>;
  @useResult
  $Res call({Duration totalDuration});
}

/// @nodoc
class _$SampleScreenStateCopyWithImpl<$Res, $Val extends SampleScreenState>
    implements $SampleScreenStateCopyWith<$Res> {
  _$SampleScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalDuration = null,
  }) {
    return _then(_value.copyWith(
      totalDuration: null == totalDuration
          ? _value.totalDuration
          : totalDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SampleScreenStateImplCopyWith<$Res>
    implements $SampleScreenStateCopyWith<$Res> {
  factory _$$SampleScreenStateImplCopyWith(_$SampleScreenStateImpl value,
          $Res Function(_$SampleScreenStateImpl) then) =
      __$$SampleScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration totalDuration});
}

/// @nodoc
class __$$SampleScreenStateImplCopyWithImpl<$Res>
    extends _$SampleScreenStateCopyWithImpl<$Res, _$SampleScreenStateImpl>
    implements _$$SampleScreenStateImplCopyWith<$Res> {
  __$$SampleScreenStateImplCopyWithImpl(_$SampleScreenStateImpl _value,
      $Res Function(_$SampleScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalDuration = null,
  }) {
    return _then(_$SampleScreenStateImpl(
      totalDuration: null == totalDuration
          ? _value.totalDuration
          : totalDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$SampleScreenStateImpl extends _SampleScreenState {
  const _$SampleScreenStateImpl({this.totalDuration = Duration.zero})
      : super._();

  @override
  @JsonKey()
  final Duration totalDuration;

  @override
  String toString() {
    return 'SampleScreenState(totalDuration: $totalDuration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SampleScreenStateImpl &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalDuration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SampleScreenStateImplCopyWith<_$SampleScreenStateImpl> get copyWith =>
      __$$SampleScreenStateImplCopyWithImpl<_$SampleScreenStateImpl>(
          this, _$identity);
}

abstract class _SampleScreenState extends SampleScreenState {
  const factory _SampleScreenState({final Duration totalDuration}) =
      _$SampleScreenStateImpl;
  const _SampleScreenState._() : super._();

  @override
  Duration get totalDuration;
  @override
  @JsonKey(ignore: true)
  _$$SampleScreenStateImplCopyWith<_$SampleScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
