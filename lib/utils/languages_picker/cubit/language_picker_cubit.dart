import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/utils/languages_picker/models/language_list.dart';

part 'language_picker_state.dart';

class LanguagePickerCubit extends Cubit<LanguagePickerState> {
  LanguagePickerCubit(String selectedLanguage) : super(LanguagePickerState()) {
    init(selectedLanguage);
  }

  void init(String selectedLanguage){
    emit(state.copyWith(languages: () => Languages.defaultLanguages, selectedLanguage: () => selectedLanguage));
  }

  void changeLanguage(String language) {
    emit(state.copyWith(selectedLanguage: () => language));
  }

  void changeTerm(String term) {
    if (term.isEmpty) {
      emit(state.copyWith(
          term: () => term, languages: () => Languages.defaultLanguages));
      return;
    }

    var lang = Languages.defaultLanguages
            .where((l) => l.toLowerCase().contains(term.toLowerCase()))
            .toList();

    emit(state.copyWith(
        languages: () => Languages.defaultLanguages
            .where((l) => l.toLowerCase().startsWith(term.toLowerCase()))
            .toList()));
  }
}
