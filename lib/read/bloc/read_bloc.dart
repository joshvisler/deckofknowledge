import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_api/read_api.dart';
import 'package:read_repository/read_repository.dart';

part 'read_event.dart';
part 'read_state.dart';

class ReadBloc extends Bloc<ReadEvent, ReadState> {
  ReadBloc({required ReadRepository readRepository})
      : _readRepository = readRepository,
        super(const ReadState()) {
    on<ReadEvent>((event, emit) {
      on<ReadSubscriptionRequested>(_onSubscriptionRequested);
      on<ArticleDeleted>(_onArticleDeleted);
      on<DialogDeleted>(_onDialogDeleted);
      on<ArticleUndoDeletionRequested>(_onArticleUndoDeletionRequested);
      on<DialogUndoDeletionRequested>(_onDialogUndoDeletionRequested);
    });
  }

  final ReadRepository _readRepository;

  Future<void> _onSubscriptionRequested(
    ReadSubscriptionRequested event,
    Emitter<ReadState> emit,
  ) async {
    emit(state.copyWith(status: () => ReadStatus.loading));

    await emit.forEach<List<ReadDialog>>(
      _readRepository.getDialogs(),
      onData: (dialogs) => state.copyWith(
        dialogs: () => dialogs,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ReadStatus.failure,
      ),
    );

    await emit.forEach<List<ReadArticle>>(
      _readRepository.getArticles(),
      onData: (articles) => state.copyWith(
        articles: () => articles,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ReadStatus.failure,
      ),
    );

    emit(state.copyWith(status: () => ReadStatus.success));
  }

  Future<void> _onDialogDeleted(
    DialogDeleted event,
    Emitter<ReadState> emit,
  ) async {
    emit(state.copyWith(lastDeletedDialog: () => event.dialog));
    await _readRepository.deleteDialog(event.dialog.id);

    await emit.forEach<List<ReadDialog>>(
      _readRepository.getDialogs(),
      onData: (dialogs) => state.copyWith(
        status: () => ReadStatus.success,
        dialogs: () => dialogs,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ReadStatus.failure,
      ),
    );
  }

  Future<void> _onArticleDeleted(
    ArticleDeleted event,
    Emitter<ReadState> emit,
  ) async {
    emit(state.copyWith(lastDeletedArticle: () => event.article));
    await _readRepository.deleteArticle(event.article.id);

    await emit.forEach<List<ReadArticle>>(
      _readRepository.getArticles(),
      onData: (articles) => state.copyWith(
        status: () => ReadStatus.success,
        articles: () => articles,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ReadStatus.failure,
      ),
    );
  }

  Future<void> _onArticleUndoDeletionRequested(
    ArticleUndoDeletionRequested event,
    Emitter<ReadState> emit,
  ) async {
    assert(
      state.lastDeletedArticle != null,
      'Last deleted todo can not be null.',
    );

    final article = state.lastDeletedArticle!;
    emit(state.copyWith(lastDeletedArticle: () => null));
    await _readRepository.addArticle(article);
  }

  Future<void> _onDialogUndoDeletionRequested(
    DialogUndoDeletionRequested event,
    Emitter<ReadState> emit,
  ) async {
    assert(
      state.lastDeletedDialog != null,
      'Last deleted todo can not be null.',
    );

    final dialog = state.lastDeletedDialog!;
    emit(state.copyWith(lastDeletedArticle: () => null));
    await _readRepository.addDialog(dialog);
  }
}
