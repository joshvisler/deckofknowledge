part of 'read_bloc.dart';

enum ReadStatus { initial, loading, success, failure }

final class ReadState extends Equatable {
  const ReadState(
      {this.status = ReadStatus.initial,
      this.dialogs,
      this.articles,
      this.lastDeletedArticle,
      this.lastDeletedDialog});

  final List<ReadDialog>? dialogs;
  final List<ReadArticle>? articles;
  final ReadStatus status;
  final ReadDialog? lastDeletedDialog;
  final ReadArticle? lastDeletedArticle;

  ReadState copyWith(
      {ReadStatus Function()? status,
      List<ReadDialog>? Function()? dialogs,
      List<ReadArticle>? Function()? articles,
      ReadDialog? Function()? lastDeletedDialog,
      ReadArticle? Function()? lastDeletedArticle}) {
    return ReadState(
        status: status != null ? status() : this.status,
        dialogs: dialogs != null ? dialogs() : this.dialogs,
        articles: articles != null ? articles() : this.articles,
        lastDeletedDialog: lastDeletedDialog != null
            ? lastDeletedDialog()
            : this.lastDeletedDialog,
        lastDeletedArticle: lastDeletedArticle != null
            ? lastDeletedArticle()
            : this.lastDeletedArticle);
  }

  @override
  List<Object?> get props =>
      [status, articles, dialogs, lastDeletedArticle, lastDeletedDialog];
}
