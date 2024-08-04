import 'package:cards_api/cards_api.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRepository {
  const GeminiRepository({
    required GenerativeModel model,
  }) : _model = model;

  final GenerativeModel _model;

  Future<WordCard> generateCard(String word) async {
    final prompt = 'Write a story about a magic backpack.';
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);

    return WordCard(
        word: word,
        translation: response.text ?? '',
        examples: [],
        tags: [],
        context: []);
  }
}
