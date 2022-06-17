import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:goethe_reading_app/model/poem.dart';
import 'package:goethe_reading_app/model/word.dart';
import 'package:goethe_reading_app/model/word_translator.dart';
import 'package:provider/provider.dart';

class WordWidget extends StatelessWidget {
  final Word word;
  final bool highlighted;
  final bool selected;
  const WordWidget(
      {Key? key,
      required this.word,
      required this.highlighted,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final poem = Provider.of<Poem>(context);
    final wordTranslator = Provider.of<WordTranslator>(context);
    final margin = highlighted ? 1.5 : 2.2;
    return GestureDetector(
      onTap: () {
        poem.selectToggleWord(word);
        wordTranslator.requestTranslation(word.text);
      },
      child: Container(
        color: word.selected ? Color(0xFF8C8AFF) : null,
        child: Padding(
          padding: EdgeInsets.only(left: margin, right: margin),
          child: Text(
            word.text,
            style: TextStyle(
              color: word.selected ? Colors.white : null,
              fontWeight: highlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
