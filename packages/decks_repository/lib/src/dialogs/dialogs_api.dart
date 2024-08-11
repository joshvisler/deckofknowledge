import 'package:decks_repository/src/dialogs/models/dialog_model.dart';

abstract class DialogsApi {
  const DialogsApi();

  Stream<List<DialogModel>> get();

  Future<void> add(DialogModel model);

  Future<void> delete(String id);

  Future<void> update(DialogModel model);
}
