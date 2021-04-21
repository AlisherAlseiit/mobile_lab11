import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChangeColorModel())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class ChangeColorModel with ChangeNotifier {
  Color _containerColor = Colors.black;
  Color _titleColor = Colors.blue;
  Color get color => _containerColor;
  Color get tColor => _titleColor;


  void _changeTitleColor() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.orange,
      Colors.amber
    ];
    _titleColor = availableColors[Random().nextInt(6)];
    notifyListeners();
  }

  void _changeContainerColor() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.orange,
      Colors.amber
    ];
    _containerColor = availableColors[Random().nextInt(6)];
    notifyListeners();
  }


}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _switch = false;


  @override
  Widget build(BuildContext context) {
    ChangeColorModel _changeColorModel = Provider.of<ChangeColorModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('App Bar',
            style:
            TextStyle(fontSize: 23, color: _changeColorModel.tColor)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              height: 250,
              width: 250,
              color: _changeColorModel.color,
            ),
            SizedBox(
              height: 25,
            ),
            Switch.adaptive(
                value: _switch,
                onChanged: (val) {
                  setState(() {
                    _switch = val;
                    _changeColorModel._changeContainerColor();
                    _changeColorModel._changeTitleColor();
                  });
                }),
          ],
        ),
      ),
    );
  }
}
