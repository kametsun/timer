import 'package:flutter/material.dart';
import 'dart:async';

import 'package:timer/view/finish_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00ff8c00)),
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
  int _workCount = 0;

  int _totalWorkTime = 0; //合計作業時間をカウントする

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (_currentTime < 1) {
          timer.cancel();
          checkWorkCount();
        } else {
          _currentTime = _currentTime - 1;
          //作業中の場合カウントさせる
          if (sessionStatus == SessionStatus.work) {
            _totalWorkTime++;
          }
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

  String getStatusLabel(SessionStatus status) {
    switch (status) {
      case SessionStatus.work:
        return "作業中";
      case SessionStatus.shortBreak:
        return "小休憩";
      case SessionStatus.longBreak:
        return "長休憩";
      default:
        return "開始待ち";
    }
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _currentTime ~/ 60;
    int seconds = _currentTime % 60;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              getStatusLabel(sessionStatus),
              style: const TextStyle(fontSize: 35, color: Colors.white),
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
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.orangeAccent),
                    ),
                  ),
                ),
                Center(
                    child: Text(
                  "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ))
              ],
            ),
            const SizedBox(
              width: double.infinity,
              height: 30,
            ),
            Row(
              children: [
                const Spacer(),
                const SizedBox(
                  width: 20,
                  height: 100,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006400),
                      foregroundColor: Colors.lightGreen,
                      minimumSize: const Size(100, 100),
                      shape: const CircleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid))),
                  onPressed: startWork,
                  child: const Text("スタート"),
                ),
                const Spacer(),
                const SizedBox(
                  height: 100,
                  width: 130,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3c3c3c),
                      minimumSize: const Size(100, 100),
                      shape: const CircleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid))),
                  onPressed: () {
                    if (_timer != null) {
                      _timer!.cancel();
                      _timer = null;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FinishPage()),
                    );
                  },
                  child: const Text(
                    "終了",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 20,
                  height: 100,
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(
              width: double.infinity,
              height: 50,
            ),
            Column(
              children: [
                const Text(
                  '合計作業時間',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${(_totalWorkTime ~/ 60).toString().padLeft(2, '0')}:${(_totalWorkTime % 60).toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
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
