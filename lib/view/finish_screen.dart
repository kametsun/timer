import 'package:flutter/material.dart';
import 'package:timer/main.dart';
import 'package:timer/theme_changer.dart';
import 'package:provider/provider.dart';

class FinishScreen extends StatelessWidget {
  final int totalWorkTime;

  const FinishScreen({Key? key, required this.totalWorkTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ThemeChangerから現在のテーマを取得
    final themeColor = Provider.of<ThemeChanger>(context).getThemeColor();
    return Scaffold(
      backgroundColor: themeColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width *
                0.8, // Here we set width to 80% of the screen width
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "お疲れ様でした",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "合計作業時間",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      "${(totalWorkTime ~/ 60).toString().padLeft(2, '0')}:${(totalWorkTime % 60).toString().padLeft(2, '0')}",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange, // foreground
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: Text("戻る", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
