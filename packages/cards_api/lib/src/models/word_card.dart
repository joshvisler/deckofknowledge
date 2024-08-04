import 'package:cards_api/src/models/json_map.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'word_card.g.dart';

@immutable
@JsonSerializable()
class WordCard extends Equatable {
  /// {@macro todo_item}
  WordCard({
    required this.word,
    String? id,
    this.translation = '',
    this.examples = const [],
    this.description = const [],
    this.context = const [],
    this.tags = const [],
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the `card`.
  ///
  /// Cannot be empty.
  final String id;

  /// The word of the `card`.
  ///
  /// Note that the title may be empty.
  final String word;

  /// The translation of the word.
  ///
  /// Note that the title may be empty.
  final String translation;

  /// The examples of the word.
  ///
  /// Defaults to an empty string.
  final List<String> examples;

  /// The description of the word.
  ///
  /// Defaults to an empty string.
  final List<String> description;

  /// The context of the word.
  ///
  /// Defaults to an empty string.
  final List<String> context;

  /// The tags of the word.
  ///
  /// Defaults to an empty string.
  final List<String> tags;

  /// Returns a copy of this `todo` with the given values updated.
  ///
  /// {@macro todo_item}
  WordCard copyWith({
    String? id,
    String? word,
    String? translation,
    List<String>? description,
    List<String>? examples,
    List<String>? context,
    List<String>? tags,
  }) {
    return WordCard(
      id: id ?? this.id,
      description: description ?? this.description,
      word: word ?? this.word,
      translation: translation ?? this.translation,
      examples: examples ?? this.examples,
      context: context ?? this.context,
      tags: tags ?? this.tags,
    );
  }

  /// Deserializes the given [JsonMap] into a [Todo].
  static WordCard fromJson(JsonMap json) => _$WordCardFromJson(json);

  /// Converts this [Todo] into a [JsonMap].
  JsonMap toJson() => _$WordCardToJson(this);

  @override
  List<Object> get props =>
      [id, word, translation, description, examples, context, tags];
}
