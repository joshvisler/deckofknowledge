import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:read_api/src/models/json_map.dart';
import 'package:uuid/uuid.dart';

part 'read_article.g.dart';

@immutable
@JsonSerializable()
class ReadArticle extends Equatable {
  /// {@macro todo_item}
  ReadArticle({
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
  final String text;
  final String theme;
  final String translate;

  ReadArticle copyWith({
    String? id,
    String? text,
    String? theme,
    String? translate,
  }) {
    return ReadArticle(
      id: id ?? this.id,
      text: text ?? this.text,
      theme: text ?? this.theme,
      translate: translate ?? this.translate,
    );
  }

  /// Deserializes the given [JsonMap] into a [Todo].
  static ReadArticle fromJson(Map<String, dynamic> json) =>
      _$ReadArticleFromJson(json);

  /// Converts this [Todo] into a [JsonMap].
  JsonMap toJson() => _$ReadArticleToJson(this);

  @override
  List<Object> get props => [id, text, translate, theme];
}
