import 'package:floating_widget/floating_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Widget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FloatingWidgetExample(),
    );
  }
}

class FloatingWidgetExample extends StatelessWidget {
  const FloatingWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Floating Widget'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: FloatingWidget(
                verticalSpace: 10,
                direction: FloatingDirection.topCenterToBottomCenter,
                duration: const Duration(
                  seconds: 3,
                ),
                reverseDuration: const Duration(seconds: 1),
                child: Image.asset('assets/images/flutter_brand.png')
              )),
        ],
      ),
    );
  }
}
