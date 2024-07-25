# flutter_gif_image

We should know that in order to achieve Gif in flutter, we can use Image, but we have no way to manipulate Gif, for example: change its speed, control it has been playing in a frame,
in which frame range loop. These problems can be solved by this widget,it also help you contain gif cache,avoid load frame every time.

# Screenshots

![](arts/gif.gif)

# Usage

add in pubspec

```dart

     flutter_gif_image: any // or the latest version on Pub

```

## GIF from Asset

```dart
    FlutterGifView.asset(
       'image_path',
       controller: GifController(),
       height: 200,
       frameRate: 30,
     )

```

## GIF from Network

```dart
    FlutterGifView.network(
    'https://www.showmetech.com.br/wp-content/uploads/2015/09/happy-minion-gif.gif',
    height: 200,
    width: 200,
  )

```

## GIF from Memory

```dart
    FlutterGifView.memory(
    _bytes,
    height: 200,
    width: 200,
  )

```

## Controller

```dart
GifController controller = GifController({
    this.autoPlay = true,
    this.loop = true,
    bool inverted = false,
    this.onStart,
    this.onFinish,
    this.onFrame,
  });

  controller.play({bool? inverted, int? initialFrame});

  controller.pause();

  controller.stop();

  controller.seek(34);

  GifStatus status = controller.status;
  // GifStatus { loading, playing, stoped, paused, reversing }

```

## If you need to preCache gif,try this

```dart
// put imageProvider
fetchGif(AssetImage("images/animate.gif"));

```

# Thanks

- [flutter_gifimage](https://github.com/peng8350/flutter_gifimage)
- [flutter_gif](https://github.com/saytoonz/flutter_gif)
- [gif_view](https://github.com/RafaelBarbosatec/gif_view)

# License

```
MIT License

Copyright (c) 2024 Jpeng

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

```
