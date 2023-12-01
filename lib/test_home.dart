import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sample_provider.dart';
import 'sample_screen.dart';

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sampleScreenProvider); // 状態を監視

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Duration: ${state.totalDuration.inSeconds} seconds',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              child: const Text('Go to TestHome'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SampleScreen()),
                );
                debugPrint('Go to TestHome');
              },
            ),
          ],
        ),
      ),
    );
  }
}
