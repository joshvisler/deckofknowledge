import 'package:decks_repository/src/dialogs/dialogs_api.dart';
import 'package:decks_repository/src/dialogs/models/dialog_model.dart';

class DialogsRepository {
  const DialogsRepository({
    required DialogsApi dialogsApi,
  }) : _dialogsApi = dialogsApi;

  final DialogsApi _dialogsApi;

  Future<void> add(DialogModel model) => _dialogsApi.add(model);

  Future<void> delete(String id) => _dialogsApi.delete(id);

  Stream<List<DialogModel>> get() => _dialogsApi.get();

  Future<void> update(DialogModel model) => _dialogsApi.update(model);
}
