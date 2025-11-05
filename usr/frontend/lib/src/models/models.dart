import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class News {
  final String id;
  final String title;
  final String excerpt;
  final String? content;
  final String url;
  final String? imageUrl;
  final DateTime publishedAt;
  final Source source;
  final int viewCount;
  final int likeCount;
  final int commentsCount;
  final bool isLiked;
  final bool isBookmarked;
  final List<String> tags;
  
  News({
    required this.id,
    required this.title,
    required this.excerpt,
    this.content,
    required this.url,
    this.imageUrl,
    required this.publishedAt,
    required this.source,
    required this.viewCount,
    required this.likeCount,
    required this.commentsCount,
    required this.isLiked,
    required this.isBookmarked,
    required this.tags,
  });
  
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['_id'] ?? json['id'],
      title: json['title'],
      excerpt: json['excerpt'],
      content: json['content'],
      url: json['url'],
      imageUrl: json['image_url'],
      publishedAt: DateTime.parse(json['published_at']),
      source: Source.fromJson(json['source']),
      viewCount: json['view_count'] ?? 0,
      likeCount: json['like_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      isLiked: json['is_liked'] ?? false,
      isBookmarked: json['is_bookmarked'] ?? false,
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}

class Source {
  final String id;
  final String name;
  final String? url;
  final bool isVerified;
  final String? category;
  
  Source({
    required this.id,
    required this.name,
    this.url,
    required this.isVerified,
    this.category,
  });
  
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      url: json['url'],
      isVerified: json['is_verified'] ?? false,
      category: json['category'],
    );
  }
}

class Comment {
  final String id;
  final String body;
  final String userId;
  final String userName;
  final String? parentId;
  final DateTime createdAt;
  final int likeCount;
  final List<Comment> replies;
  
  Comment({
    required this.id,
    required this.body,
    required this.userId,
    required this.userName,
    this.parentId,
    required this.createdAt,
    required this.likeCount,
    required this.replies,
  });
  
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'] ?? json['id'],
      body: json['body'],
      userId: json['user_id'],
      userName: json['user_name'] ?? 'Anonymous',
      parentId: json['parent_id'],
      createdAt: DateTime.parse(json['created_at']),
      likeCount: json['like_count'] ?? 0,
      replies: (json['replies'] as List? ?? []).map((e) => Comment.fromJson(e)).toList(),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final List<String> roles;
  final List<String> followedSources;
  final Map<String, dynamic> settings;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    required this.followedSources,
    required this.settings,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      email: json['email'],
      roles: List<String>.from(json['roles'] ?? []),
      followedSources: List<String>.from(json['followed_sources'] ?? []),
      settings: Map<String, dynamic>.from(json['settings'] ?? {}),
    );
  }
}