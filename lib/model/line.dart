import 'package:goethe_reading_app/model/word.dart';

class Line {
  final List<Word> words;
  final String lineTranslation;
  bool selected;
  Line(this.words, {this.lineTranslation = ''}) : selected = false;
}
