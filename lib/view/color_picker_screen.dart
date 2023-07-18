import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerScreen extends StatefulWidget {
  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  Color pickerColor = Color(0xFF00000000);

  @override
  void initState() {
    super.initState();
    loadFontFromList();
  }

  loadColorFromPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int colorInt = sharedPreferences.getInt("color");
    if (colorInt != null) {
      setState(() {
        pickerColor = Color(colorInt);
      });
    }
  }

  saveColorToPreferences(Color color) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("color", color.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("色選択"),
      ),
    );
  }
}
