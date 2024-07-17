import 'dart:math';

import 'package:arrow_decoration/arrow_decoration.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arrow Decoration Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Arrow Decoration Example'),
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
  Color lineColor = Colors.green;
  Color bgColor = Colors.pink;
  double lineWidth = 10;
  BorderRadius borderRadius = BorderRadius.zero;
  double extra = 0;
  ArrowPosition arrowPosition = ArrowPosition.right;
  Size arrowSize = const Size(50, 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          decoration: ArrowDecoration(
            bgColor: bgColor,
            lineColor: lineColor,
            lineWidth: lineWidth,
            borderRadius: borderRadius,
            extra: extra,
            arrowPosition: arrowPosition,
            arrowSize: arrowSize,
            strokeMiterLimit: 9999,
          ),
          width: 200,
          height: 200,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final random = Random();

          bgColor = Color.fromRGBO(
            random.nextInt(255),
            random.nextInt(255),
            random.nextInt(255),
            1,
          );
          lineColor = Color.fromRGBO(
            random.nextInt(255),
            random.nextInt(255),
            random.nextInt(255),
            1,
          );
          lineWidth = random.nextDouble() * 10;
          borderRadius = BorderRadius.circular(random.nextDouble() * 10);
          extra = random.nextInt(50).toDouble();
          arrowSize = Size(random.nextDouble() * 50, random.nextDouble() * 50);
          arrowPosition = ArrowPosition.values[random.nextInt(4)];

          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
