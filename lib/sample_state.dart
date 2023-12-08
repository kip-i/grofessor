import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample_state.freezed.dart';

@freezed
class SampleScreenState with _$SampleScreenState {
  const SampleScreenState._();

  const factory SampleScreenState({
    @Default(Duration.zero) Duration totalDuration,
  }) = _SampleScreenState;
}
