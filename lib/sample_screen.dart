import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sample_provider.dart';
import '../const/color.dart';

class SampleScreen extends ConsumerStatefulWidget {
  @override
  _SampleScreenState createState() => _SampleScreenState();
}

class _SampleScreenState extends ConsumerState<SampleScreen> {
  bool isButtonPressed = false;

  @override
  void initState() {
    super.initState();
    ref.read(sampleScreenProvider.notifier).isActive = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sampleScreenProvider); // 状態を監視
    Duration totalDuration = state.totalDuration;
    int hours = totalDuration.inHours;
    int minutes = (totalDuration.inMinutes % 60);
    int seconds = (totalDuration.inSeconds % 60);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 49, 48, 48),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '経過時間: $hours:$minutes:$seconds',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 187, 187, 187),
                    ),
                  ),
                  // ストップボタン
                  ElevatedButton(
                    onPressed: () {
                      isButtonPressed = false;
                      ref.read(sampleScreenProvider.notifier).stopDuration(
                          // totalDuration
                          //     .inMilliseconds); // stopDurationメソッドを呼び出し
                          totalDuration.inSeconds); // stopDurationメソッドを呼び出し
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blackbordColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      '終了',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
