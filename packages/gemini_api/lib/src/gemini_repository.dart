import 'dart:convert';
import 'dart:developer';

import 'package:decks_repository/decks_repository.dart';
import 'package:gemini_api/src/models/text_generated_model.dart';
import 'package:gemini_api/src/models/word_generated_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';

class GeminiRepository {
  const GeminiRepository({
    required GenerativeModel model,
  }) : _model = model;

  final GenerativeModel _model;

  Future<WordGeneratedModel> generateCard(String word, String languageFrom, String languageTo) async {
    final prompt = '''I want learn $languageFrom word "$word". And translate to $languageTo
input: I want learn German word "word"
output:{"word": "Angaben", "translate": "information, details, specifications", "description": ["Plural noun for 'Angabe'", "Refers to factual data or information provided in a form or application", "Can also refer to statements or declarations made in a formal context"], "tags": ["noun", "plural"], "examples": ["Bitte geben Sie Ihre persönlichen Angaben an.", "Die Angaben auf dem Formular sind unvollständig.", "Die technischen Angaben des Produkts sind beeindruckend."], "context": ["Commonly used in forms, applications, and official documents to request information."
"Can also be used in everyday conversations to refer to facts or details."]}''';
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content,
        generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
            responseSchema: Schema.object(properties: {
              'word': Schema.string(),
              'translate': Schema.string(),
              'examples': Schema.array(items: Schema.string()),
              'description': Schema.array(items: Schema.string()),
              'context': Schema.array(items: Schema.string()),
              'tags': Schema.array(items: Schema.string()),
            })));

    var jsonString =
        response.text!.replaceAll('json', '').replaceAll("```", '').trim();

    log(jsonString);
    Map<String, dynamic> modelJson = json.decode(jsonString);

    return WordGeneratedModel.fromJson(modelJson);
  }

  Future<TextGeneratedModel> generateDialog(String theme, String languageFrom, String languageTo) async {
    final prompt = '''Create dialog in $languageFrom for theme "$theme" max 1000 words. And translate to $languageTo
input: Create dialog in German for theme "Rent apartments" max 500 words
output:{"theme": "Wohnungssuche in Berlin", "text": ["Szene: Zwei Freunde, Anna und Max, sitzen in einem Café in Berlin.", "Anna: Max, ich bin so fertig mit der Wohnungssuche! Ich hab schon seit Wochen unzählige Anzeigen durchgeblättert, aber nichts Passendes gefunden.", "Max: Ich verstehe dich. Berlin ist ja auch nicht gerade günstig. Und die Konkurrenz ist riesig. Hast du schon bei Immobilienscout oder Immowelt geschaut?"], translate:["Scene: Two friends, Anna and Max, are sitting in a café in Berlin.", "Anna: Max, I'm so exhausted from apartment hunting! I've been flipping through countless listings for weeks, but haven't found anything suitable.", "Max: I understand. Berlin isn't exactly cheap. And the competition is huge. Have you checked Immobilienscout or Immowelt?"]}''';
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content,
    generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
            responseSchema: Schema.object(properties: {
              'theme': Schema.string(),
              'translate': Schema.array(items: Schema.string()),
              'text': Schema.array(items: Schema.string()),
            })));

    var jsonString =
        response.text!.replaceAll('json', '').replaceAll("```", '').trim();

    log(jsonString);
    Map<String, dynamic> modelJson = json.decode(jsonString);

    return TextGeneratedModel.fromJson(modelJson);
  }

  Future<TextGeneratedModel> generateStory(String theme, String languageFrom, String languageTo) async {
    final prompt =
        '''Create story in $languageFrom for theme "${theme}" max 1000 words with translation to $languageTo
input: Create story in German for theme "Toy boy" max 300 words
output:{"theme": "Die Puppe und der Spieler", "text": ["Der Duft von Vanille und frisch gebrühtem Kaffee lag in der Luft, als Leo die Bar betrat. In seinem grauen Anzug wirkte er wie ein Raubtier, das in das Revier eines anderen eindrang. Doch sein Blick, der sich über den Raum glitt, verriet eine Unsicherheit. Er suchte, suchte sie.
Er hatte sie vor zwei Wochen in dieser Bar getroffen. Sie hatte blonde, wallende Haare, die wie ein Wasserfall über ihre Schultern fielen, und Augen, die in einem tiefen Blau schimmerten, wie das Meer an einem stürmischen Tag. Ihre Haut war samtig weich und ihr Lächeln strahlte eine jugendliche Energie aus, die ihn in ihren Bann gezogen hatte. Sie hieß Clara und war, wie er später erfuhr, zwanzig Jahre älter als er.", "translate":"The scent of vanilla and freshly brewed coffee hung in the air as Leo entered the bar. In his gray suit, he looked like a predator intruding on another's territory. But his gaze, which swept across the room, betrayed a sense of uncertainty. He searched, for her.", "He had met her in this bar two weeks ago. She had blonde, flowing hair that cascaded over her shoulders like a waterfall, and eyes that shimmered a deep blue, like the sea on a stormy day. Her skin was velvety soft, and her smile radiated a youthful energy that had captivated him. Her name was Clara, and, as he later learned, she was twenty years older than him."], "translate": ["The aroma of vanilla and freshly brewed coffee filled the air as Leo entered the bar. In his gray suit, he resembled a predator encroaching on another's domain. Yet, his eyes, which scanned the room, revealed an air of uncertainty. He searched, for her.", "He had met her in this bar two weeks prior. She possessed blonde, flowing hair that cascaded over her shoulders like a waterfall, and eyes that shimmered a deep blue, like the sea during a tempest. Her skin was velvety soft, and her smile exuded a youthful energy that had captivated him. Her name was Clara, and, as he later discovered, she was twenty years his senior."]}''';
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content,
    generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
            responseSchema: Schema.object(properties: {
              'theme': Schema.string(),
              'translate': Schema.array(items: Schema.string()),
              'text': Schema.array(items: Schema.string()),
            })));

    var jsonString =
        response.text!.replaceAll('json', '').replaceAll("```", '').trim();

    log(jsonString);
    Map<String, dynamic> modelJson = json.decode(jsonString);

    return TextGeneratedModel.fromJson(modelJson);
  }
}
