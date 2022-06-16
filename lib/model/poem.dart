import 'package:flutter/material.dart';
import 'package:goethe_reading_app/model/line.dart';
import 'package:goethe_reading_app/model/strophe.dart';
import 'package:goethe_reading_app/model/word.dart';

class Poem extends ChangeNotifier {
  final List<Strophe> strophes;
  Line? _currentSelectedLine;
  Word? _currentSelectedWord;
  bool _translationVisible = false;
  Poem(this.strophes);

  Line? get currentSelectedLine => _currentSelectedLine;
  Word? get currentSelectedWord => _currentSelectedWord;
  bool get translationVisible => _translationVisible;

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
