import 'package:decks_repository/decks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'story_model.g.dart';

@immutable
@JsonSerializable()
class StoryModel extends Equatable {
  StoryModel({
    required this.text,
    required this.theme,
    required this.deckId,
    String? id,
    this.translate = '',
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String deckId;
  final String text;
  final String theme;
  final String translate;

  StoryModel copyWith({
    String? id,
    String? deckId,
    String? text,
    String? theme,
    String? translate,
  }) {
    return StoryModel(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      text: text ?? this.text,
      theme: text ?? this.theme,
      translate: translate ?? this.translate,
    );
  }

  static StoryModel fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  JsonMap toJson() => _$StoryModelToJson(this);

  @override
  List<Object> get props => [id, deckId, text, translate, theme];
}
