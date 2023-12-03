import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sample_provider.dart';
import 'sample_screen.dart';

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(sampleScreenProvider.notifier); // コントローラーを取得

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<int>(
              future: controller.getTime(), // getTimeメソッドを呼び出す
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  if (snapshot.data == null) {
                    return Text('Saved Time: 0 seconds');
                  } else {
                    return Text(
                        'Saved Time: ${(snapshot.data! / 1000).floor()} seconds');
                  }
                }
              },
            ),
            ElevatedButton(
              child: const Text('Go to TestHome'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SampleScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
