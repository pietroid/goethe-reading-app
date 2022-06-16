import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:goethe_reading_app/model/poem.dart';
import 'package:goethe_reading_app/model/word.dart';
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
    final margin = highlighted ? 2.0 : 3.0;
    //highlighted ? 2.0 : 3.0;
    return GestureDetector(
      onTap: () {
        poem.selectToggleWord(word);
      },
      child: Container(
        color: word.selected ? Colors.blue : null,
        child: Padding(
          padding: EdgeInsets.only(left: margin, right: margin),
          child: Text(
            word.text,
            style: TextStyle(
                fontWeight: highlighted ? FontWeight.bold : FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
