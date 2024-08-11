import 'package:decks_repository/decks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'dialog_model.g.dart';

@immutable
@JsonSerializable()
class DialogModel extends Equatable {
  DialogModel({
    required this.text,
    required this.translate,
    required this.theme,
    required this.deckId,
    String? id,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String deckId;
  final List<String> text;
  final List<String> translate;
  final String theme;

  DialogModel copyWith({
    String? id,
    String? deckId,
    List<String>? text,
    List<String>? translate,
    String? theme,
    String? description,
  }) {
    return DialogModel(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      text: text ?? this.text,
      theme: theme ?? this.theme,
      translate: translate ?? this.translate,
    );
  }

  static DialogModel fromJson(Map<String, dynamic> json) =>
      _$DialogModelFromJson(json);

  JsonMap toJson() => _$DialogModelToJson(this);

  @override
  List<Object> get props => [id, deckId, text, translate, theme];
}
