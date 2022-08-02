import 'package:flutter/material.dart';

class SandBox extends StatefulWidget {
  const SandBox({Key? key}) : super(key: key);

  @override
  _SandBoxState createState() => _SandBoxState();
}

class _SandBoxState extends State<SandBox> {
  double _margin = 20;
  Color _color = Colors.blue;
  double _opacity = 1;
  double _width = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: _width,
        color: _color,
        margin: EdgeInsets.all(_margin),
        child: Column(
          children: [
            MaterialButton(
              onPressed: () => setState(() => _margin = 50),
              child: Text('Animate margin'),
            ),
            MaterialButton(
              onPressed: () => setState(() => _color = Colors.purple),
              child: Text('Animate color'),
            ),
            MaterialButton(
              onPressed: () => setState(() => _width = 400),
              child: Text('Animate width'),
            ),
            MaterialButton(
              onPressed: () => setState(() => _opacity = 0.25),
              child: Text('Animate opacity'),
            ),
            SizedBox(height: 100),
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              child: Text(
                'Hide me',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}