import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goethe_reading_app/model/line.dart';
import 'package:goethe_reading_app/model/strophe.dart';
import 'package:goethe_reading_app/model/word.dart';

class Poem extends ChangeNotifier {
  final List<Strophe> strophes = [];
  Line? _currentSelectedLine;
  Word? _currentSelectedWord;
  bool _translationVisible = false;

  Line? get currentSelectedLine => _currentSelectedLine;
  Word? get currentSelectedWord => _currentSelectedWord;
  bool get translationVisible => _translationVisible;

  Future<void> loadPoem() async {
    final originalText = await rootBundle.loadString('assets/original.txt');
    final translatedText = await rootBundle.loadString('assets/translated.txt');
    final originalLines = originalText.split('\n');
    final translatedLines = translatedText.split('\n');
    int lineIndex = 0;
    List<Line> linesOfStrophe = [];
    originalLines.forEach((line) {
      if (line.trim() == '') {
        strophes.add(Strophe(linesOfStrophe));
        print('lines of strophe ${linesOfStrophe.length}');
        linesOfStrophe = [];
      } else {
        List<Word> words = line.split(' ').map((text) => Word(text)).toList();
        linesOfStrophe
            .add(Line(words, lineTranslation: translatedLines[lineIndex]));
      }
      lineIndex++;
    });
    notifyListeners();
  }

  void selectLine(int lineIndex) {
    _currentSelectedLine?.selected = false;
    for (final strophe in strophes) {
      if (lineIndex < strophe.lines.length) {
        if (lineIndex >= 0) {
          strophe.lines[lineIndex].selected = true;
          _currentSelectedLine = strophe.lines[lineIndex];
        } else {
          _currentSelectedLine = null;
        }
        break;
      } else {
        lineIndex -= strophe.lines.length + 1;
      }
    }
    notifyListeners();
  }

  void selectToggleWord(Word selectedWord) {
    _currentSelectedWord?.selected = false;
    if (selectedWord == _currentSelectedWord) {
      _currentSelectedWord = null;
    } else {
      selectedWord.selected = true;
      _currentSelectedWord = selectedWord;
    }
    notifyListeners();
  }

  void unselectWord() {
    _currentSelectedWord?.selected = false;
    _currentSelectedWord = null;
    notifyListeners();
  }

  void toggleTranslation() {
    _translationVisible = !_translationVisible;
    notifyListeners();
  }
}
