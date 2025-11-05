import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulsex/src/models/models.dart';

class CommentsScreen extends ConsumerWidget {
  final String articleId;
  
  const CommentsScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // TODO: Use actual comments
              itemBuilder: (context, index) {
                return CommentWidget(
                  comment: Comment(
                    id: 'comment_$index',
                    body: 'This is a sample comment #$index',
                    userId: 'user_$index',
                    userName: 'User $index',
                    createdAt: DateTime.now(),
                    likeCount: index,
                    replies: [],
                  ),
                );
              },
            ),
          ),
          const CommentInput(),
        ],
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final Comment comment;
  
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Text(comment.userName[0]),
              ),
              const SizedBox(width: 8),
              Text(
                comment.userName,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              Text(
                '${comment.likeCount} likes',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(comment.body),
          const SizedBox(height: 8),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Like'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Reply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CommentInput extends StatefulWidget {
  const CommentInput({super.key});

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Write a comment...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // TODO: Send comment
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}