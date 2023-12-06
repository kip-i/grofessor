import 'package:flutter/material.dart';

import 'selected_display.dart';


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
          height: MediaQuery.of(context).size.height / 2.4,
          child: SelectedDisplay(),
        )
      ],
    );
  }
}
