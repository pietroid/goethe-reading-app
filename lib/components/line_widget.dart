import 'package:flutter/material.dart';
import 'package:goethe_reading_app/components/word_widget.dart';
import 'package:goethe_reading_app/model/line.dart';

class LineWidget extends StatelessWidget {
  final Line line;
  const LineWidget({
    Key? key,
    required this.line,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Row(
        children: line.words
            .map((word) => WordWidget(
                  word: word,
                  highlighted: line.selected,
                  selected: false,
                ))
            .toList(),
      ),
    );
  }
}
