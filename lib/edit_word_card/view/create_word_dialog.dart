import 'dart:developer';

import 'package:cards_repository/cards_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:myapp/edit_word_card/bloc/edit_word_card_bloc.dart';
import 'package:myapp/l10n/l10n.dart';

class EditWordCard extends StatelessWidget {
  const EditWordCard({super.key, required this.isCreatingMode, this.card});

  final bool isCreatingMode;
  final WordCard? card;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditWordCardBloc(
        cardsRepository: context.read<CardsRepository>(),
        geminiRepository: context.read<GeminiRepository>(),
      )..add(EditWordCardSubscriptionRequested(isCreatingMode, card)),
      child: EditWordCardDialog(
        isCreatingMode: isCreatingMode,
        card: card,
      ),
    );
  }
}

class EditWordCardDialog extends StatelessWidget {
  const EditWordCardDialog(
      {super.key, required this.isCreatingMode, this.card});

  final bool isCreatingMode;
  final WordCard? card;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Dialog.fullscreen(
        child: Scaffold(
      appBar: AppBar(
        title: isCreatingMode
            ? const Text('Create word card')
            : const Text('Edit word card'),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                    const SnackBar(
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
            } else if (state.isCreating &&
                state.status == EditCardStatus.initial) {
              return SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Center(
                                    child: FilledButton(
                                        statesController:
                                            WidgetStatesController(),
                                        onPressed: state.wordText == ''
                                            ? null
                                            : () => context
                                                .read<EditWordCardBloc>()
                                                .add(
                                                    const EditWordCardGenerateCard()),
                                        child: const Text('Generate'))))
                          ])));
            } else if (state.card != null) {
              return SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(state.card!.word,
                                style:
                                    Theme.of(context).textTheme.headlineLarge)),
                        Center(
                            child: Text(state.card!.translate,
                                style:
                                    Theme.of(context).textTheme.headlineSmall)),
                        const Divider(),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                                alignment: WrapAlignment.start,
                                runSpacing: 8,
                                spacing: 8,
                                children: state.card!.tags
                                    .map<Widget>((x) => Chip(
                                          label: Text(x),
                                        ))
                                    .toList())),
                        const SizedBox(height: 24),
                        if (state.card!.description.isNotEmpty)
                          Text('Description',
                              style: Theme.of(context).textTheme.titleMedium),
                        Wrap(
                          children: state.card!.description
                              .map<Widget>((x) => Text(
                                    x,
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 24),
                        Text('Contexts',
                            style: Theme.of(context).textTheme.titleMedium),
                        Wrap(
                          children: state.card!.context
                              .map<Widget>((x) => Text(
                                    x,
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 24),
                        Text('Examples',
                            style: Theme.of(context).textTheme.titleMedium),
                        Wrap(
                          children: state.card!.examples
                              .map<Widget>((x) => Text(
                                    x,
                                  ))
                              .toList(),
                        ),
                      ],
                    )),
              );
            } else {
              return const Text('Something wrong with card');
            }
          },
        ),
      ),
    ));
  }
}
