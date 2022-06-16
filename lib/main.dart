import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:goethe_reading_app/components/indicator.dart';
import 'package:goethe_reading_app/components/line_widget.dart';
import 'package:goethe_reading_app/components/strophe_widget.dart';
import 'package:goethe_reading_app/model/line.dart';
import 'package:goethe_reading_app/model/poem.dart';
import 'package:goethe_reading_app/model/strophe.dart';
import 'package:goethe_reading_app/model/word.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Poem([
        Strophe([
          Line([Word('Das'), Word('Buch'), Word('ist'), Word('langweilig')],
              lineTranslation: 'The book is boring'),
          Line([Word('Das'), Word('Buch'), Word('ist'), Word('langweilig')],
              lineTranslation: 'The book is boring'),
          Line([Word('Das'), Word('Buch'), Word('ist'), Word('langweilig')],
              lineTranslation: 'The book is boring'),
          Line([Word('Das'), Word('Buch'), Word('ist'), Word('langweilig')],
              lineTranslation: 'The book is boring'),
        ]),
        Strophe([
          Line([Word('Das'), Word('Buch'), Word('ist'), Word('langweilig')],
              lineTranslation: 'The book is boring'),
          Line([Word('Das'), Word('Buch'), Word('ist'), Word('langweilig')],
              lineTranslation: 'The book is boring'),
          Line([Word('Das'), Word('Buch'), Word('ist'), Word('langweilig')],
              lineTranslation: 'The book is boring'),
          Line([Word('Das'), Word('Buch'), Word('ist'), Word('langweilig')],
              lineTranslation: 'The book is boring'),
        ]),
        Strophe([
          Line([Word('Das'), Word('Buch'), Word('ist'), Word('langweilig')],
              lineTranslation: 'The book is boring'),
          Line([Word('Das'), Word('Buch'), Word('ist'), Word('langweilig')],
              lineTranslation: 'The book is boring'),
          Line([Word('Das'), Word('Buch'), Word('ist'), Word('langweilig')],
              lineTranslation: 'The book is boring'),
          Line([Word('Das'), Word('Buch'), Word('ist'), Word('langweilig')],
              lineTranslation: 'The book is boring'),
        ]),
      ]),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const MaterialColor white = const MaterialColor(
      0xFFFFFFFF,
      const <int, Color>{
        50: const Color(0xFFFFFFFF),
        100: const Color(0xFFFFFFFF),
        200: const Color(0xFFFFFFFF),
        300: const Color(0xFFFFFFFF),
        400: const Color(0xFFFFFFFF),
        500: const Color(0xFFFFFFFF),
        600: const Color(0xFFFFFFFF),
        700: const Color(0xFFFFFFFF),
        800: const Color(0xFFFFFFFF),
        900: const Color(0xFFFFFFFF),
      },
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: const MyHomePage(title: 'Der Zauberlehring'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final poem = Provider.of<Poem>(context);
    final ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 0)
        poem.selectLine((_scrollController.offset / 20).toInt());
    });
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: poem.strophes.length + 2,
                      itemBuilder: ((context, index) {
                        if (index == 0) {
                          return SizedBox(height: 100);
                        }
                        if (index == poem.strophes.length + 1) {
                          return SizedBox(height: 1000);
                        }
                        return StropheWidget(
                          lines: poem.strophes[index - 1].lines.map((line) {
                            return LineWidget(line: line);
                          }).toList(),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Indicator(),
                  ),
                ],
              ),
            ),
          ),
          if (poem.currentSelectedWord != null)
            SizedBox(
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
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hexenmeister',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text('Sorcerer')
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
            ),
          SizedBox(
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
                    child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          Text(poem.currentSelectedLine?.lineTranslation ?? ''),
                          if (!poem.translationVisible)
                            ClipRect(
                              child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 3.0, sigmaY: 3.0),
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
                  ))),
        ],
      ),
    );
  }
}
