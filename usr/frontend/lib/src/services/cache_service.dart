import 'package:hive/hive.dart';

class CacheService {
  static const String _cacheBox = 'cache';
  static const String _bookmarksBox = 'bookmarks';
  
  late Box _cache;
  late Box _bookmarks;
  
  Future<void> init() async {
    _cache = await Hive.openBox(_cacheBox);
    _bookmarks = await Hive.openBox(_bookmarksBox);
  }
  
  // Cache news feed
  Future<void> cacheFeed(String key, List<dynamic> data, {Duration ttl = const Duration(hours: 1)}) async {
    final expiry = DateTime.now().add(ttl).millisecondsSinceEpoch;
    await _cache.put(key, {
      'data': data,
      'expiry': expiry,
    });
  }
  
  List<dynamic>? getCachedFeed(String key) {
    final cached = _cache.get(key);
    if (cached == null) return null;
    
    final expiry = cached['expiry'];
    if (DateTime.now().millisecondsSinceEpoch > expiry) {
      _cache.delete(key);
      return null;
    }
    
    return cached['data'];
  }
  
  // Bookmarks
  Future<void> addBookmark(String articleId) async {
    await _bookmarks.put(articleId, true);
  }
  
  Future<void> removeBookmark(String articleId) async {
    await _bookmarks.delete(articleId);
  }
  
  bool isBookmarked(String articleId) {
    return _bookmarks.get(articleId) == true;
  }
  
  List<String> getAllBookmarks() {
    return _bookmarks.keys.cast<String>().toList();
  }
  
  // Sync queue for offline actions
  Future<void> enqueueAction(String action, Map<String, dynamic> data) async {
    final queue = _cache.get('sync_queue') ?? [];
    queue.add({
      'action': action,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    });
    await _cache.put('sync_queue', queue);
  }
  
  List<Map<String, dynamic>> getSyncQueue() {
    return List<Map<String, dynamic>>.from(_cache.get('sync_queue') ?? []);
  }
  
  Future<void> clearSyncQueue() async {
    await _cache.delete('sync_queue');
  }
}

final cacheServiceProvider = Provider<CacheService>((ref) {
  final service = CacheService();
  service.init();
  return service;
});