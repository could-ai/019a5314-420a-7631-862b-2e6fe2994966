import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulsex/src/services/api_service.dart';
import 'package:pulsex/src/models/models.dart';

final newsProvider = StateNotifierProvider<NewsNotifier, AsyncValue<List<News>>>((ref) {
  final api = ref.watch(apiServiceProvider);
  return NewsNotifier(api);
});

class NewsNotifier extends StateNotifier<AsyncValue<List<News>>> {
  final ApiService _api;
  
  NewsNotifier(this._api) : super(const AsyncValue.loading()) {
    loadFeed();
  }
  
  Future<void> loadFeed({int page = 1, String tab = 'for_you'}) async {
    state = const AsyncValue.loading();
    try {
      final response = await _api.dio.get('/news/', queryParameters: {
        'page': page,
        'limit': 20,
        'tab': tab,
      });
      
      final news = (response.data['results'] as List)
        .map((json) => News.fromJson(json))
        .toList();
      
      state = AsyncValue.data(news);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> toggleLike(String newsId) async {
    try {
      final response = await _api.dio.post('/news/$newsId/like/');
      
      // Update local state optimistically
      state = state.whenData((news) {
        return news.map((item) {
          if (item.id == newsId) {
            return item.copyWith(
              isLiked: response.data['is_liked'],
              likeCount: response.data['like_count'],
            );
          }
          return item;
        }).toList();
      });
    } catch (e) {
      // Revert optimistic update on error
      loadFeed();
    }
  }
}

extension NewsExtension on News {
  News copyWith({
    String? id,
    String? title,
    String? excerpt,
    String? content,
    String? url,
    String? imageUrl,
    DateTime? publishedAt,
    Source? source,
    int? viewCount,
    int? likeCount,
    int? commentsCount,
    bool? isLiked,
    bool? isBookmarked,
    List<String>? tags,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      excerpt: excerpt ?? this.excerpt,
      content: content ?? this.content,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      source: source ?? this.source,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      tags: tags ?? this.tags,
    );
  }
}