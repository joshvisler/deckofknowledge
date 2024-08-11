// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryModel _$StoryModelFromJson(Map<String, dynamic> json) => StoryModel(
      text: json['text'] as String,
      theme: json['theme'] as String,
      deckId: json['deckId'] as String,
      id: json['id'] as String?,
      translate: json['translate'] as String? ?? '',
    );

Map<String, dynamic> _$StoryModelToJson(StoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deckId': instance.deckId,
      'text': instance.text,
      'theme': instance.theme,
      'translate': instance.translate,
    };
