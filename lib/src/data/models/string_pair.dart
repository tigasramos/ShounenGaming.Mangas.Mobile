import 'package:freezed_annotation/freezed_annotation.dart';

part 'string_pair.freezed.dart';
part 'string_pair.g.dart';

@freezed
class StringPair with _$StringPair {
  factory StringPair({
    required String id,
    required String value,
  }) = _StringPair;

  factory StringPair.fromJson(Map<String, dynamic> json) =>
      _$StringPairFromJson(json);
}
