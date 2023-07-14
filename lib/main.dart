import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'タイマー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "作業中",
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(
              width: double.infinity,
              height: 100,
            ),
            const Text(
              'mm:ss',
              style: TextStyle(fontSize: 80),
            ),
            const SizedBox(
              width: double.infinity,
              height: 30,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                  height: 100,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 100),
                      shape: const CircleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid))),
                  onPressed: null,
                  child: const Text("キャンセル"),
                ),
                const SizedBox(
                  height: 100,
                  width: 130,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 100),
                      shape: const CircleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid))),
                  onPressed: null,
                  child: const Text("終了"),
                ),
                const SizedBox(
                  width: 20,
                  height: 100,
                ),
              ],
            ),
            const SizedBox(
              width: double.infinity,
              height: 80,
            ),
            const Column(
              children: [
                Text(
                  '合計作業時間',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "mm:ss",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
