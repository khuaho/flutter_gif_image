import 'dart:io';
import 'dart:ui' as ui show Codec;
// ignore: unnecessary_import
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gif_image/flutter_gif_image.dart';

final HttpClient _sharedHttpClient = HttpClient()..autoUncompress = false;

HttpClient get _httpClient {
  HttpClient client = _sharedHttpClient;

  assert(
    () {
      if (debugNetworkImageHttpClientProvider != null) {
        client = debugNetworkImageHttpClientProvider!();
      }
      return true;
    }(),
  );

  return client;
}

Future<List<ImageInfo>> fetchGif(ImageProvider provider) async {
  List<ImageInfo> infos = [];
  final Uint8List bytes;
  final String key = provider is NetworkImage
      ? provider.url
      : provider is AssetImage
          ? provider.assetName
          : provider is MemoryImage
              ? provider.bytes.toString()
              : "";

  if (FlutterGifView.cache.caches.containsKey(key)) {
    infos = FlutterGifView.cache.caches[key]!;
    return infos;
  }

  if (provider is NetworkImage) {
    final Uri resolved = Uri.base.resolve(provider.url);
    final HttpClientRequest request = await _httpClient.getUrl(resolved);
    provider.headers?.forEach((String name, String value) {
      request.headers.add(name, value);
    });
    final HttpClientResponse response = await request.close();
    bytes = await consolidateHttpClientResponseBytes(
      response,
    );
  } else if (provider is AssetImage) {
    AssetBundleImageKey key =
        await provider.obtainKey(const ImageConfiguration());
    bytes = (await key.bundle.load(key.name)).buffer.asUint8List();
  } else if (provider is FileImage) {
    bytes = await provider.file.readAsBytes();
  } else if (provider is MemoryImage) {
    bytes = provider.bytes;
  } else {
    throw Exception("Unsupported image provider");
  }

  final buffer = await ImmutableBuffer.fromUint8List(bytes);
  ui.Codec codec = await instantiateImageCodecFromBuffer(buffer);
  for (int i = 0; i < codec.frameCount; i++) {
    final frameInfo = await codec.getNextFrame();
    final duration = frameInfo.duration.inSeconds;
    for (int sec = 1; sec <= duration; sec++) {
      infos.add(ImageInfo(image: frameInfo.image));
    }
  }
  return infos;
}
