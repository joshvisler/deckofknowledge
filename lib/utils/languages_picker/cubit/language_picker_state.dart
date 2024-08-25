part of 'language_picker_cubit.dart';

final class LanguagePickerState extends Equatable {
  const LanguagePickerState(
      {this.selectedLanguage = 'German', this.term = '', this.languages = const []});

  final String selectedLanguage;
  final String term;
  final List<String> languages;

  LanguagePickerState copyWith({
    List<String> Function()? languages,
    String Function()? term,
    String Function()? selectedLanguage,
  }) {
    return LanguagePickerState(
        languages: languages != null ? languages() : this.languages,
        term: term != null ? term() : this.term,
        selectedLanguage: selectedLanguage != null ? selectedLanguage() : this.selectedLanguage);
  }

  @override
  List<Object> get props => [selectedLanguage, term, languages];
}
