import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsContent extends StatefulWidget {
  final String articleId;
  
  const NewsContent({super.key, required this.articleId});

  @override
  State<NewsContent> createState() => _NewsContentState();
}

class _NewsContentState extends State<NewsContent> {
  late WebViewController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            // Show loading
          },
          onPageFinished: (String url) {
            // Hide loading
          },
        ),
      )
      ..loadRequest(Uri.parse('https://example.com/article/${widget.articleId}')); // TODO: Load actual article URL
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: WebViewWidget(controller: _controller),
    );
  }
}