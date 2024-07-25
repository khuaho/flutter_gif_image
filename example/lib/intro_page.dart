import 'package:flutter/material.dart';
import 'package:flutter_gif_image/flutter_gif_image.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<String> gifList = [
    'images/animate.gif',
    'https://www.showmetech.com.br/wp-content/uploads/2015/09/happy-minion-gif.gif',
    'https://gifs.eco.br/wp-content/uploads/2021/08/engracados-memes-gif-19.gif'
  ];

  late List<GifController> gifControllerList;

  @override
  void initState() {
    gifControllerList = List.generate(
      gifList.length,
      (index) => GifController(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Demo'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Gif load from asset',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const Divider(),
          FlutterGifView.asset(
            'images/animate.gif',
            controller: GifController(
              onStart: () {
                // TODO:
                print('Hello start');
              },
              onFinish: () {
                print('Hello finish');
              },
              onFrame: (value) {
                print('frame: $value');
              },
            ),
            height: 200,
            frameRate: 30,
          ),
        ],
      ),
    );
  }
}
