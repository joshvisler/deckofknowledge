// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      word: json['word'] as String,
      id: json['id'] as String?,
      translation: json['translation'] as String? ?? '',
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

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'translation': instance.translation,
      'examples': instance.examples,
      'description': instance.description,
      'context': instance.context,
      'tags': instance.tags,
    };
