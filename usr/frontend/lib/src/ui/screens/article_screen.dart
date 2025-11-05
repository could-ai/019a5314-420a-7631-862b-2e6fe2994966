import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulsex/src/models/models.dart';
import 'package:pulsex/src/ui/widgets/news_content.dart';
import 'package:pulsex/src/ui/widgets/comments_section.dart';

class ArticleScreen extends ConsumerWidget {
  final String articleId;
  
  const ArticleScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              // TODO: Implement bookmark
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewsContent(articleId: articleId),
            const Divider(),
            CommentsSection(articleId: articleId),
          ],
        ),
      ),
    );
  }
}