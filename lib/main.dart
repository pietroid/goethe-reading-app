import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:goethe_reading_app/components/indicator.dart';
import 'package:goethe_reading_app/components/line_translation_bottom_menu.dart';
import 'package:goethe_reading_app/components/line_widget.dart';
import 'package:goethe_reading_app/components/strophe_widget.dart';
import 'package:goethe_reading_app/components/word_translation_bottom_menu.dart';
import 'package:goethe_reading_app/model/line.dart';
import 'package:goethe_reading_app/model/poem.dart';
import 'package:goethe_reading_app/model/strophe.dart';
import 'package:goethe_reading_app/model/word.dart';
import 'package:goethe_reading_app/model/word_translator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => Poem()),
      ChangeNotifierProvider(create: (context) => WordTranslator())
    ], child: const MyApp()),
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
      title: 'Read Goethe',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: const MyHomePage(title: 'Der Zauberlehring'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final poem = Provider.of<Poem>(context, listen: false);
      await poem.loadPoem();
      poem.selectLine(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final poem = Provider.of<Poem>(context);

    _scrollController.addListener(() {
      if (_scrollController.offset >= 0)
        poem.selectLine((_scrollController.offset / 20).toInt());
    });
    if (poem.strophes.length > 0) print('length: ${poem.strophes[1].lines}');
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 0.0),
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
                  const Padding(
                    padding: const EdgeInsets.only(top: 85),
                    child: Indicator(),
                  ),
                ],
              ),
            ),
          ),
          if (poem.currentSelectedWord != null)
            const WordTranslationBottomMenu(),
          const LineTranslationBottomMenu(),
        ],
      ),
    );
  }
}
