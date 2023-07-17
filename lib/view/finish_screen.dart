import 'package:flutter/material.dart';
import 'package:timer/main.dart';

class FinishScreen extends StatelessWidget {
  final int totalWorkTime;

  const FinishScreen({Key? key, required this.totalWorkTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
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
                    Text(
                      "お疲れ様でした",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "合計作業時間",
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    Text(
                      "${(totalWorkTime ~/ 60).toString().padLeft(2, '0')}:${(totalWorkTime % 60).toString().padLeft(2, '0')}",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
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
