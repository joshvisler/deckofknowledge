import 'package:decks_repository/decks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'deck_model.g.dart';

@immutable
@JsonSerializable()
class DeckModel extends Equatable {
  DeckModel(
      {required this.title,
      String? id,
      this.cardsNumber = 0,
      this.storiesNumber = 0,
      this.dialogsNumber = 0})
      : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final int cardsNumber;
  final int storiesNumber;
  final int dialogsNumber;

  DeckModel copyWith({
    String? id,
    String? title,
    int? cardsNumber,
    int? storiesNumber,
    int? dialogsNumber,
  }) {
    return DeckModel(
      id: id ?? this.id,
      title: title ?? this.title,
      cardsNumber: cardsNumber ?? this.cardsNumber,
      storiesNumber: storiesNumber ?? this.storiesNumber,
      dialogsNumber: dialogsNumber ?? this.dialogsNumber,
    );
  }

  static DeckModel fromJson(Map<String, dynamic> json) =>
      _$DeckModelFromJson(json);

  JsonMap toJson() => _$DeckModelToJson(this);

  @override
  List<Object> get props =>
      [id, title, cardsNumber, storiesNumber, dialogsNumber];
}
