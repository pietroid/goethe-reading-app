import 'package:flutter/material.dart';
import 'package:goethe_reading_app/components/line_widget.dart';
import 'package:goethe_reading_app/model/line.dart';

class StropheWidget extends StatelessWidget {
  final List<LineWidget> lines;
  const StropheWidget({Key? key, required this.lines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...lines,
      LineWidget(
        line: Line([]),
      )
    ]);
  }
}
