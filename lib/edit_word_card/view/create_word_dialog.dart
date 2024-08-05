import 'dart:developer';

import 'package:cards_repository/cards_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:myapp/edit_word_card/bloc/edit_word_card_bloc.dart';
import 'package:myapp/l10n/l10n.dart';

class EditWordCard extends StatelessWidget {
  const EditWordCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditWordCardBloc(
        cardsRepository: context.read<CardsRepository>(),
        geminiRepository: context.read<GeminiRepository>(),
      )..add(const EditWordCardSubscriptionRequested()),
      child: const EditWordCardDialog(),
    );
  }
}

class EditWordCardDialog extends StatelessWidget {
  const EditWordCardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Dialog.fullscreen(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Create word card'),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: context.read<EditWordCardBloc>().state.card == null
                ? null
                : () =>
                    {context.read<EditWordCardBloc>().add(EditWordCardSave())},
            child: const Text('Save'),
          )
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EditWordCardBloc, EditWordCardState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == EditCardStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('Error occured'),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<EditWordCardBloc, EditWordCardState>(
          builder: (context, state) {
            if (state.status == EditCardStatus.generating ||
                state.status == EditCardStatus.saving) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter a search term',
                          ),
                          onChanged: (value) => {
                            context
                                .read<EditWordCardBloc>()
                                .add(EditWordEnterWord(value))
                          },
                        ),
                        FilledButton(
                            statesController: WidgetStatesController(),
                            onPressed: state.wordText == ''
                                ? null
                                : () => context
                                    .read<EditWordCardBloc>()
                                    .add(EditWordCardGenerateCard()),
                            child: Text('Generate'))
                      ],
                    )),
              );
            }
          },
        ),
      ),
    ));
  }
}
