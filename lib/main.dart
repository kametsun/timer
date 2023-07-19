import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer/theme_changer.dart';
import 'package:timer/view/timer_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //セーブされた色を取得
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int colorValue = preferences.getInt("color") ?? Colors.blue.value;
  Color customColor = Color(colorValue);

  runApp(ChangeNotifierProvider<ThemeChanger>(
    create: (_) => ThemeChanger(customColor),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: themeColor.getThemeColor(),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: themeColor.getThemeColor()),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TimerScreen(),
    );
  }
}
