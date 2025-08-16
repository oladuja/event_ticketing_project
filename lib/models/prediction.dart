import 'package:json_annotation/json_annotation.dart';

part 'prediction.g.dart';

@JsonSerializable()
class Prediction {
  final String? description;

  @JsonKey(name: 'place_id')
  final String? placeId;

  final String? reference;

  @JsonKey(name: 'structured_formatting')
  final StructuredFormatting? structuredFormatting;

  Prediction({
    this.description,
    this.placeId,
    this.reference,
    this.structuredFormatting,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionToJson(this);
}

@JsonSerializable()
class StructuredFormatting {
  @JsonKey(name: 'main_text')
  final String? mainText;

  @JsonKey(name: 'secondary_text')
  final String? secondaryText;

  StructuredFormatting({
    this.mainText,
    this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredFormattingToJson(this);
}
