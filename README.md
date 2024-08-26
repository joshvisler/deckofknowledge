# Deck of Knowledge

An AI-powered language learning app designed to help users expand their vocabulary and improve reading comprehension. Create personalized flashcards with AI-generated definitions and examples. Challenge yourself with interactive reading exercises and track your progress. Learn efficiently and effectively with Deck of Knowledge.

App working only on Android. 

This app created in platform idx.google.com



**Install guide** 

First install Flutter SDK (App using SDK version '>=3.4.3 <4.0.0')
    [Install  Flutter](https://docs.flutter.dev/get-started/install)
    
To use this sample, you'll need a Gemini API key. You can find instructions for generating one at 
[https://ai.google.dev/](https://ai.google.dev/).     
    
  Set Gemini API key in app in lib/bootstrap.dart
		
	model:  GenerativeModel(model:  'gemini-1.5-flash', apiKey:  'YOUR Gemini API key'));

**App concepts** 

Deck - is folder for cards, stories and dialogs.
Flashcard - card for learning new word.
Story and Dialog - its short text for up your skill in reading

## **Create Deck**

![enter image description here](https://github.com/joshvisler/deckofknowledge/blob/main/docs/images/create_deck.gif)

## **Create Card & Cards view**

![enter image description here](https://github.com/joshvisler/deckofknowledge/blob/main/docs/images/cards.gif)

## **Create Dialog and Story**

![enter image description here](https://github.com/joshvisler/deckofknowledge/blob/main/docs/images/create_story.gif)
![enter image description here](https://github.com/joshvisler/deckofknowledge/blob/main/docs/images/dialog_story_view.gif)
