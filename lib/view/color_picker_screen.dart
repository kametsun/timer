import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:timer/theme_changer.dart';
import 'package:timer/view/timer_screen.dart';

class ColorPickerScreen extends StatefulWidget {
  const ColorPickerScreen({super.key});

  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  late Color myColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myColor = Theme.of(context).primaryColor;
  }

  Future<void> saveColorToPrefs(Color color) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("color", color.value);
  }

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("色選択"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                showDialog(
                  builder: (context) => AlertDialog(
                    title: const Text('色を選択'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: themeChanger.getThemeColor(),
                        onColorChanged: (color) {
                          // TODO: 変更時処理
                          themeChanger.setThemeColor(color);
                        },
                      ),
                    ),
                  ),
                  context: context,
                );
              },
              child: const Text('カラーピッカーを表示する'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text("戻る"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TimerScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
