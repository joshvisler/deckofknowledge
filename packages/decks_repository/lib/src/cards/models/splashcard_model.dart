import '../../models/json_map.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'splashcard_model.g.dart';

@immutable
@JsonSerializable()
class SplashCardModel extends Equatable {
  SplashCardModel({
    required this.word,
    String? id,
    required this.deckId,
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
  final String deckId;
  final String word;
  final String translate;
  final List<String> examples;
  final List<String> description;
  final List<String> context;
  final List<String> tags;

  SplashCardModel copyWith({
    String? id,
    String? deckId,
    String? word,
    String? translate,
    List<String>? description,
    List<String>? examples,
    List<String>? context,
    List<String>? tags,
  }) {
    return SplashCardModel(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      description: description ?? this.description,
      word: word ?? this.word,
      translate: translate ?? this.translate,
      examples: examples ?? this.examples,
      context: context ?? this.context,
      tags: tags ?? this.tags,
    );
  }

  static SplashCardModel fromJson(Map<String, dynamic> json) =>
      _$SplashCardModelFromJson(json);

  JsonMap toJson() => _$SplashCardModelToJson(this);

  @override
  List<Object> get props =>
      [id, deckId, word, translate, description, examples, context, tags];
}
