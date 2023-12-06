import 'package:flutter/material.dart';

import 'selected_display.dart';
import 'selector_tab.dart';

class DressUp extends StatefulWidget {
  const DressUp({Key? key}) : super(key: key);

  @override
  State<DressUp> createState() => _DressUpState();
}

class _DressUpState extends State<DressUp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 10 / 14 - 70,
          child: SelectedDisplay(),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 4 / 14,
          child: SelectorTab(),
        ),
      ],
    );
  }
}
