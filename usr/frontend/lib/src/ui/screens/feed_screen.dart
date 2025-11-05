import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulsex/src/providers/news_provider.dart';
import 'package:pulsex/src/ui/widgets/news_card.dart';
import 'package:pulsex/src/ui/widgets/tab_bar.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final newsAsync = ref.watch(newsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('PulseX'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'For You'),
            Tab(text: 'Following'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedList(newsAsync, 'for_you'),
          _buildFeedList(newsAsync, 'following'),
        ],
      ),
    );
  }
  
  Widget _buildFeedList(AsyncValue<List<dynamic>> newsAsync, String tab) {
    return RefreshIndicator(
      onRefresh: () => ref.read(newsProvider.notifier).loadFeed(tab: tab),
      child: newsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (news) => ListView.builder(
          itemCount: news.length,
          itemBuilder: (context, index) {
            final item = news[index];
            return NewsCard(news: item);
          },
        ),
      ),
    );
  }
}