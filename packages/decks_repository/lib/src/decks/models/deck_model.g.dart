// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeckModel _$DeckModelFromJson(Map<String, dynamic> json) => DeckModel(
      title: json['title'] as String,
      languageFrom: json['languageFrom'] as String? ?? 'German',
      languageTo: json['languageTo'] as String? ?? 'English',
      id: json['id'] as String?,
      cardsNumber: (json['cardsNumber'] as num?)?.toInt() ?? 0,
      storiesNumber: (json['storiesNumber'] as num?)?.toInt() ?? 0,
      dialogsNumber: (json['dialogsNumber'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DeckModelToJson(DeckModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'languageFrom': instance.languageFrom,
      'languageTo': instance.languageTo,
      'cardsNumber': instance.cardsNumber,
      'storiesNumber': instance.storiesNumber,
      'dialogsNumber': instance.dialogsNumber,
    };
