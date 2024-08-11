// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DialogModel _$DialogModelFromJson(Map<String, dynamic> json) => DialogModel(
      text: (json['text'] as List<dynamic>).map((e) => e as String).toList(),
      translate:
          (json['translate'] as List<dynamic>).map((e) => e as String).toList(),
      theme: json['theme'] as String,
      deckId: json['deckId'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$DialogModelToJson(DialogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deckId': instance.deckId,
      'text': instance.text,
      'translate': instance.translate,
      'theme': instance.theme,
    };
