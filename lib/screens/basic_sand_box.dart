import 'package:flutter/material.dart';
import 'package:ninja_trips/shared/details/box_to_hide.dart';
import 'package:ninja_trips/shared/sand_box/sand_box_button.dart';

class BasicSandBox extends StatefulWidget {
  const BasicSandBox({Key? key}) : super(key: key);

  @override
  _BasicSandBoxState createState() => _BasicSandBoxState();
}

class _BasicSandBoxState extends State<BasicSandBox> {
  double _margin = 20;
  double _opacity = 1;
  double _width = 200;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Sand box'),
      ),
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: _width,
        color: _color,
        margin: EdgeInsets.all(_margin),
        child: _column(),
        padding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _column() {
    return Column(
      children: [
        SandBoxButton(
          onTap: () => setState(() => _margin = 50),
          text: 'Animate margin',
        ),
        SandBoxButton(
          onTap: () => setState(() => _color = Colors.purple),
          text: 'Animate color',
        ),
        SandBoxButton(
          onTap: () => setState(() => _width = 400),
          text: 'Animate width',
        ),
        SandBoxButton(
          onTap: () => setState(() => _opacity = 0.25),
          text: 'Animate opacity',
        ),
        SizedBox(height: 100),
        BoxToHide(opacity: _opacity),
      ],
    );
  }
}
