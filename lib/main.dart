import 'package:flutter/material.dart';
import 'dart:async';

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

//状態を表す
enum SessionStatus { none, work, shortBreak, longBreak }

class _MyHomePageState extends State<MyHomePage> {
  SessionStatus sessionStatus = SessionStatus.none; //初期値はnone => スタート待ち状態
  static int WORK_TIME = 25;
  static int SHORT_BREAK_TIME = 5;
  static int LONG_BREAK_TIME = 15;

  Timer? _timer;
  int _start = WORK_TIME * 60; //60秒 * 25分 => 25分を秒数換算(初期値)
  int _currentTime = WORK_TIME * 60;
  int _workCount = 3;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (_currentTime < 1) {
          timer.cancel();
          checkWorkCount();
        } else {
          _currentTime = _currentTime - 1;
        }
      });
    });
  }

  void startWork() {
    if (sessionStatus == SessionStatus.none) {
      sessionStatus = SessionStatus.work;
      setCurrentTimeToWorkTime();
      startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // _currentTimeを作業時間に設定
  void setCurrentTimeToWorkTime() {
    _currentTime = WORK_TIME * 60;
    _start = WORK_TIME * 60;
  }

  // _currentTimeを小休憩時間に設定
  void setCurrentTimeToShortBreak() {
    _currentTime = SHORT_BREAK_TIME * 60;
    _start = SHORT_BREAK_TIME * 60;
  }

  // _currentTimeを長休憩時間に設定
  void setCurrentTimeToLongBreak() {
    _currentTime = LONG_BREAK_TIME * 60;
    _start = LONG_BREAK_TIME * 60;
  }

  /*
   *タイマーが0になったときcheckWorkCount()を必ず通す。 
   */
  void checkWorkCount() {
    if (sessionStatus == SessionStatus.work) {
      _workCount++;
      if (_workCount == 4) {
        sessionStatus = SessionStatus.longBreak;
        setCurrentTimeToLongBreak();
        _workCount = 0;
      } else {
        sessionStatus = SessionStatus.shortBreak;
        setCurrentTimeToShortBreak();
      }
    } else {
      sessionStatus = SessionStatus.work;
      setCurrentTimeToWorkTime();
    }
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    int _minutes = _currentTime ~/ 60;
    int _seconds = _currentTime % 60;

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
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 280,
                    width: 280,
                    child: CircularProgressIndicator(
                      value: _currentTime / _start.toDouble(),
                      strokeWidth: 15,
                    ),
                  ),
                ),
                Center(
                    child: Text(
                  "${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: 50),
                ))
              ],
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
                  onPressed: startWork,
                  child: const Text("スタート"),
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
              height: 50,
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
