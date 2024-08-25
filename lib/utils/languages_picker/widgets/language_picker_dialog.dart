import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/utils/languages_picker/cubit/language_picker_cubit.dart';

class LanguagePickerDialog extends StatelessWidget {
  const LanguagePickerDialog(
      {super.key, required this.onValuePicked, this.title, required this.selectedLanguage});

  final ValueChanged<String> onValuePicked;
  final String? title;
  final String selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguagePickerCubit(selectedLanguage),
      child: Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            title: Text(title != null && title!.isNotEmpty
                ? title!
                : 'Select Language'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: BlocBuilder<LanguagePickerCubit, LanguagePickerState>(
            builder: (context, state) {
              return Padding(
                  padding: EdgeInsets.only(
                    top: 24,
                    left: 24,
                    right: 24,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Expanded(
                      child: Column(children: [
                    TextField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Search',
                        ),
                        onChanged: (value) => context
                            .read<LanguagePickerCubit>()
                            .changeTerm(value)),
                    Expanded(
                        child: ListView.builder(
                      itemCount: state.languages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.languages[index]),
                          leading: state.languages[index] == selectedLanguage ? const Icon(Icons.done) : null ,
                          onTap: () => {
                            onValuePicked(state.languages[index]),
                            Navigator.of(context).pop()
                          },
                        );
                      },
                    ))
                  ])));
            },
          ),
        ),
      ),
    );
  }
}
