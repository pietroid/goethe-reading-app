import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:goethe_reading_app/model/poem.dart';
import 'package:provider/provider.dart';

class LineTranslationBottomMenu extends StatelessWidget {
  const LineTranslationBottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final poem = Provider.of<Poem>(context);
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Color(0xFFBABABA)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(alignment: AlignmentDirectional.centerStart, children: [
            Text(poem.currentSelectedLine?.lineTranslation ?? ''),
            if (!poem.translationVisible)
              ClipRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container()),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    poem.toggleTranslation();
                  },
                  icon: poem.translationVisible
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
