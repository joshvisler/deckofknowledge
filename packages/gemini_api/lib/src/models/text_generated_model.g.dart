// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_generated_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextGeneratedModel _$TextGeneratedModelFromJson(Map<String, dynamic> json) =>
    TextGeneratedModel(
      theme: json['theme'] as String,
      translate: (json['translate'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      text:
          (json['text'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$TextGeneratedModelToJson(TextGeneratedModel instance) =>
    <String, dynamic>{
      'theme': instance.theme,
      'translate': instance.translate,
      'text': instance.text,
    };
