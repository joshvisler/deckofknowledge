import 'package:decks_repository/decks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'text_generated_model.g.dart';

@immutable
@JsonSerializable()
class TextGeneratedModel extends Equatable {
  const TextGeneratedModel({
    required this.theme,
    this.translate = const [],
    this.text = const [],
  });

  final String theme;
  final List<String> translate;
  final List<String> text;

  TextGeneratedModel copyWith({
    String? theme,
    List<String>? translate,
    List<String>? text,
  }) {
    return TextGeneratedModel(
      theme: theme ?? this.theme,
      translate: translate ?? this.translate,
      text: text ?? this.text,
    );
  }

  static TextGeneratedModel fromJson(Map<String, dynamic> json) =>
      _$TextGeneratedModelFromJson(json);

  JsonMap toJson() => _$TextGeneratedModelToJson(this);

  @override
  List<Object> get props => [theme, translate, text, translate];
}
