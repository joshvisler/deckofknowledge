// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splashcard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplashCardModel _$SplashCardModelFromJson(Map<String, dynamic> json) =>
    SplashCardModel(
      word: json['word'] as String,
      id: json['id'] as String?,
      deckId: json['deckId'] as String,
      translate: json['translate'] as String? ?? '',
      examples: (json['examples'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      description: (json['description'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      context: (json['context'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$SplashCardModelToJson(SplashCardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deckId': instance.deckId,
      'word': instance.word,
      'translate': instance.translate,
      'examples': instance.examples,
      'description': instance.description,
      'context': instance.context,
      'tags': instance.tags,
    };
