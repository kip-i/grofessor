import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sample_provider.dart';

class SampleScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sampleScreenProvider); // 状態を監視

    return Scaffold(
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
