// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryModel _$StoryModelFromJson(Map<String, dynamic> json) => StoryModel(
      text: (json['text'] as List<dynamic>).map((e) => e as String).toList(),
      theme: json['theme'] as String,
      deckId: json['deckId'] as String,
      id: json['id'] as String?,
      translate: (json['translate'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$StoryModelToJson(StoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deckId': instance.deckId,
      'text': instance.text,
      'translate': instance.translate,
      'theme': instance.theme,
    };
