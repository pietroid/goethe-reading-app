import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:goethe_reading_app/model/poem.dart';
import 'package:goethe_reading_app/model/word_translator.dart';
import 'package:provider/provider.dart';

class WordTranslationBottomMenu extends StatelessWidget {
  const WordTranslationBottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final poem = Provider.of<Poem>(context);
    final wordTranslator = Provider.of<WordTranslator>(context);

    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Color(0xFFBABABA)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              wordTranslator.loadingState == LoadingState.loading
                  ? CircularProgressIndicator(
                      color: Colors.grey,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(
                            wordTranslator.wordToBeTranslated,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(wordTranslator.translation)
                        ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: poem.unselectWord,
                      icon: Icon(Icons.close),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
