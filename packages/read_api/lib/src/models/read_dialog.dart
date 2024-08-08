import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:read_api/src/models/json_map.dart';
import 'package:uuid/uuid.dart';

part 'read_dialog.g.dart';

@immutable
@JsonSerializable()
class ReadDialog extends Equatable {
  ReadDialog({
    required this.text,
    required this.theme,
    String? id,
    this.translate = '',
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final List<String> text;
  final List<String> theme;
  final String translate;

  ReadDialog copyWith({
    String? id,
    List<String>? text,
    List<String>? theme,
    String? translate,
    String? description,
  }) {
    return ReadDialog(
      id: id ?? this.id,
      text: text ?? this.text,
      theme: theme ?? this.theme,
      translate: translate ?? this.translate,
    );
  }

  /// Deserializes the given [JsonMap] into a [Todo].
  static ReadDialog fromJson(Map<String, dynamic> json) =>
      _$ReadDialogFromJson(json);

  /// Converts this [Todo] into a [JsonMap].
  JsonMap toJson() => _$ReadDialogToJson(this);

  @override
  List<Object> get props => [id, text, translate, theme];
}
