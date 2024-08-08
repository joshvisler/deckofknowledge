// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadArticle _$ReadArticleFromJson(Map<String, dynamic> json) => ReadArticle(
      text: json['text'] as String,
      theme: json['theme'] as String,
      id: json['id'] as String?,
      translate: json['translate'] as String? ?? '',
    );

Map<String, dynamic> _$ReadArticleToJson(ReadArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'theme': instance.theme,
      'translate': instance.translate,
    };
