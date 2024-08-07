import 'dart:convert';
import 'dart:developer';

import 'package:cards_api/cards_api.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRepository {
  const GeminiRepository({
    required GenerativeModel model,
  }) : _model = model;

  final GenerativeModel _model;

  Future<WordCard> generateCard(String word) async {
    final prompt = '''I want learn German word "$word"
input: I want learn German word "word"
output:{"word": "Angaben", "translate": "information, details, specifications", "description": ["Plural noun for 'Angabe'", "Refers to factual data or information provided in a form or application", "Can also refer to statements or declarations made in a formal context"], "tags": ["noun", "plural"], "examples": ["Bitte geben Sie Ihre persönlichen Angaben an.", "Die Angaben auf dem Formular sind unvollständig.", "Die technischen Angaben des Produkts sind beeindruckend."], "context": ["Commonly used in forms, applications, and official documents to request information."
"Can also be used in everyday conversations to refer to facts or details."]}''';
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);

    var jsonString =
        response.text!.replaceAll('json', '').replaceAll("```", '').trim();

    log(jsonString);
    Map<String, dynamic> modelJson = json.decode(jsonString);

    return WordCard.fromJson(modelJson);
  }
}
