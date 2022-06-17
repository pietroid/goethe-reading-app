import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class WordTranslator extends ChangeNotifier {
  final _googleTranslator = GoogleTranslator();
  LoadingState _loadingState = LoadingState.completed;

  String _translation = '';
  String _wordToBeTranslated = '';

  String get translation => _translation;
  String get wordToBeTranslated => _wordToBeTranslated;
  LoadingState get loadingState => _loadingState;

  Future<void> requestTranslation(String wordToBeTranslated) async {
    _wordToBeTranslated = wordToBeTranslated;
    _loadingState = LoadingState.loading;
    notifyListeners();
    try {
      _translation = await _translate(wordToBeTranslated);
      _loadingState = LoadingState.completed;
    } catch (e) {
      _loadingState = LoadingState.error;
    }
    notifyListeners();
  }

  Future<String> _translate(String wordToBeTranslated) async {
    final translation = await _googleTranslator.translate(wordToBeTranslated,
        from: 'de', to: 'en');
    return translation.text;
  }
}

enum LoadingState {
  loading,
  completed,
  error,
}
