import 'package:flutter/material.dart';

import '../const/color.dart';
import 'model_tab.dart';
import 'background_tab.dart';

class SelectorTab extends StatefulWidget {
  const SelectorTab({Key? key}) : super(key: key);

  @override
  State<SelectorTab> createState() => _SelectorTabState();
}

class _SelectorTabState extends State<SelectorTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TabBar(
          tabs: [
            Tab(
              child: Text('モデル',
                style: TextStyle(
                  fontSize: 16,
                )
              ),
            ),
            Tab(
              child: Text('背景',
                style: TextStyle(
                  fontSize: 16,
                )
              ),
            ),
          ],
          controller: _tabController,
          labelColor: accentColor,
          unselectedLabelColor: unselectedColor,
          indicatorColor: accentColor,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ModelTab(),
              BackgroundTab(),
            ],
          ),
        ),
      ],
    );
  }
}
