import 'package:flutter/material.dart';

class PulseXTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;
  
  const PulseXTabBar({super.key, required this.controller, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs.map((tab) => Tab(text: tab)).toList(),
    );
  }
}