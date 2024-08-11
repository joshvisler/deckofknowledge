import 'dart:convert';

import 'package:decks_repository/decks_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialogsStorageApi extends DialogsApi {
  DialogsStorageApi({required SharedPreferences preferences})
      : _preferences = preferences {
    _init();
  }

  final SharedPreferences _preferences;

  late final _dialogsStreamController =
      BehaviorSubject<List<DialogModel>>.seeded(
    const [],
  );

  @visibleForTesting
  static const kDialogsCollectionKey = '__dialogs_collection_key__';

  String? _getValue(String key) => _preferences.getString(key);
  Future<void> _setValue(String key, String value) =>
      _preferences.setString(key, value);

  void _init() {
    final dialogsJson = _getValue(kDialogsCollectionKey);
    if (dialogsJson != null) {
      final dialogs = List<Map<dynamic, dynamic>>.from(
        json.decode(dialogsJson) as List,
      )
          .map((jsonMap) =>
              DialogModel.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _dialogsStreamController.add(dialogs);
    } else {
      _dialogsStreamController.add(const []);
    }
  }

  @override
  Future<void> add(DialogModel model) {
    final dialogs = [..._dialogsStreamController.value, model];
    final cardIndex = dialogs.indexWhere((c) => c.id == model.id);
    if (cardIndex != -1) {
      dialogs[cardIndex] = model;
    } else {
      dialogs.add(model);
    }

    _dialogsStreamController.add(dialogs);
    return _setValue(kDialogsCollectionKey, json.encode(dialogs));
  }

  @override
  Future<void> delete(String id) {
    final dialogs = [..._dialogsStreamController.value];
    final cardIndex = dialogs.indexWhere((c) => c.id == id);

    if (cardIndex != -1) {
      dialogs.removeAt(cardIndex);
      _dialogsStreamController.add(dialogs);
      return _setValue(kDialogsCollectionKey, json.encode(dialogs));
    } else {
      throw CardNotFoundException();
    }
  }

  @override
  Stream<List<DialogModel>> get() {
    return _dialogsStreamController.asBroadcastStream();
  }

  @override
  Future<void> update(DialogModel model) {
    final dialogs = [..._dialogsStreamController.value, model];
    final cardIndex = dialogs.indexWhere((c) => c.id == model.id);

    if (cardIndex != -1) {
      dialogs[cardIndex] = model;
    }

    _dialogsStreamController.add(dialogs);
    return _setValue(kDialogsCollectionKey, json.encode(dialogs));
  }
}
