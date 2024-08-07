// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordCard _$WordCardFromJson(Map<String, dynamic> json) => WordCard(
      word: json['word'] as String,
      id: json['id'] as String?,
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

Map<String, dynamic> _$WordCardToJson(WordCard instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'translate': instance.translate,
      'examples': instance.examples,
      'description': instance.description,
      'context': instance.context,
      'tags': instance.tags,
    };
