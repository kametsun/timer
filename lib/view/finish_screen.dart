import 'package:flutter/material.dart';
import 'package:timer/main.dart';

class FinishScreen extends StatelessWidget {
  final int totalWorkTime;

  const FinishScreen({Key? key, required this.totalWorkTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("お疲れ様でした"),
            const Text("合計作業時間"),
            Text(
              "${(totalWorkTime ~/ 60).toString().padLeft(2, '0')}:${(totalWorkTime % 60).toString().padLeft(2, '0')}",
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()));
              },
              child: const Text("戻る"),
            ),
          ],
        ),
      ),
    );
  }
}
