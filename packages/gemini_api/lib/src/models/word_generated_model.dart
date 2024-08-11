import 'package:decks_repository/decks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'word_generated_model.g.dart';

@immutable
@JsonSerializable()
class WordGeneratedModel extends Equatable {
  WordGeneratedModel({
    required this.word,
    String? id,
    this.translate = '',
    this.examples = const [],
    this.description = const [],
    this.context = const [],
    this.tags = const [],
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String word;
  final String translate;
  final List<String> examples;
  final List<String> description;
  final List<String> context;
  final List<String> tags;

  WordGeneratedModel copyWith({
    String? id,
    String? word,
    String? translate,
    List<String>? description,
    List<String>? examples,
    List<String>? context,
    List<String>? tags,
  }) {
    return WordGeneratedModel(
      id: id ?? this.id,
      description: description ?? this.description,
      word: word ?? this.word,
      translate: translate ?? this.translate,
      examples: examples ?? this.examples,
      context: context ?? this.context,
      tags: tags ?? this.tags,
    );
  }

  static WordGeneratedModel fromJson(Map<String, dynamic> json) =>
      _$WordGeneratedModelFromJson(json);

  JsonMap toJson() => _$WordGeneratedModelToJson(this);

  @override
  List<Object> get props =>
      [id, word, translate, description, examples, context, tags];
}
