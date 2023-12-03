import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sample_provider.dart';

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
    debugPrint('isButtonPressed: $isButtonPressed');

    return Scaffold(
      backgroundColor: isButtonPressed
          ? const Color.fromARGB(255, 113, 113, 113)
          : Colors.white, // 背景色を変更
      appBar: AppBar(
        title: Text('Sample Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Duration: ${state.totalDuration.inSeconds} seconds',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // スタートボタン
            ElevatedButton(
              onPressed: () {
                isButtonPressed = true;
                ref.read(sampleScreenProvider.notifier).startTimer();
              },
              child: Text(
                ' Start',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // ストップボタン
            ElevatedButton(
              onPressed: () {
                isButtonPressed = false;
                ref
                    .read(sampleScreenProvider.notifier)
                    .stopDuration(); // stopDurationメソッドを呼び出し
              },
              child: Text(
                ' Stop',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // リセットボタン
            ElevatedButton(
              onPressed: () {
                isButtonPressed = false;
                ref
                    .read(sampleScreenProvider.notifier)
                    .resetDuration(); // resetDurationメソッドを呼び出し
              },
              child: Text(
                ' Reset',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ), // 総経過時間を表示
      ),
    );
  }
}
