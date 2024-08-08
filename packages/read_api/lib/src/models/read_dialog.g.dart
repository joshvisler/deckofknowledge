// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_dialog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadDialog _$ReadDialogFromJson(Map<String, dynamic> json) => ReadDialog(
      text: (json['text'] as List<dynamic>).map((e) => e as String).toList(),
      theme: (json['theme'] as List<dynamic>).map((e) => e as String).toList(),
      id: json['id'] as String?,
      translate: json['translate'] as String? ?? '',
    );

Map<String, dynamic> _$ReadDialogToJson(ReadDialog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'theme': instance.theme,
      'translate': instance.translate,
    };
