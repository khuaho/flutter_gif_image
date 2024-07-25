import 'package:flutter/widgets.dart';

class GifCache {
  final caches = <String, List<ImageInfo>>{};

  void clear() {
    caches.clear();
  }

  bool evict(Object key) {
    final List<ImageInfo>? pendingImage = caches.remove(key);

    if (pendingImage != null) {
      return true;
    }

    return false;
  }
}
