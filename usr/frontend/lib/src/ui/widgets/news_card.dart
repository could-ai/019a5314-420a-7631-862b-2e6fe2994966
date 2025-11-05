import 'package:flutter/material.dart';
import 'package:pulsex/src/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsCard extends StatelessWidget {
  final News news;
  
  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to article
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    child: Text(news.source.name[0]),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    news.source.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  if (news.source.isVerified)
                    const Icon(Icons.verified, size: 16, color: Colors.blue),
                  const Spacer(),
                  Text(
                    timeago.format(news.publishedAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                news.title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                news.excerpt,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              if (news.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: news.imageUrl!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => const SizedBox(
                      height: 200,
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      news.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: news.isLiked ? Colors.red : null,
                    ),
                    onPressed: () {
                      // TODO: Toggle like
                    },
                  ),
                  Text('${news.likeCount}'),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      // TODO: Navigate to comments
                    },
                  ),
                  Text('${news.commentsCount}'),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      news.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    ),
                    onPressed: () {
                      // TODO: Toggle bookmark
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      // TODO: Share
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}