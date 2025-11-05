import 'package:flutter/material.dart';

class CommentsSection extends StatelessWidget {
  final String articleId;
  
  const CommentsSection({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Comments',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5, // TODO: Use actual comments count
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(child: Text('U')),
              title: Text('User $index'),
              subtitle: Text('This is a sample comment #$index'),
              trailing: Text('${index} likes'),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              // TODO: Navigate to full comments screen
            },
            child: const Text('View All Comments'),
          ),
        ),
      ],
    );
  }
}