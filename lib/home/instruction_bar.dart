import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class InstructionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80.0,
      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Expanded(
        child: Marquee(
          text: '予定の時刻です。計測を開始してください。',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          blankSpace: 90.0,
          startAfter: const Duration(seconds: 1),
          pauseAfterRound: const Duration(seconds: 1),
        ),
      ),
    );
  }
}
