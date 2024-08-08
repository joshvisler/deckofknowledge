part of 'read_bloc.dart';

sealed class ReadEvent extends Equatable {
  const ReadEvent();

  @override
  List<Object> get props => [];
}

final class ReadSubscriptionRequested extends ReadEvent {
  const ReadSubscriptionRequested();
}

final class DialogDeleted extends ReadEvent {
  const DialogDeleted(this.dialog);

  final ReadDialog dialog;

  @override
  List<Object> get props => [dialog];
}

final class ArticleDeleted extends ReadEvent {
  const ArticleDeleted(this.article);

  final ReadArticle article;

  @override
  List<Object> get props => [article];
}

final class DialogUndoDeletionRequested extends ReadEvent {
  const DialogUndoDeletionRequested();
}

final class ArticleUndoDeletionRequested extends ReadEvent {
  const ArticleUndoDeletionRequested();
}
