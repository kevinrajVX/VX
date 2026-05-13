import 'package:flutter/material.dart';

void main() {
  runApp(const VXCodeApp());
}

class VXCodeApp extends StatelessWidget {
  const VXCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VX Code',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VX Code'),
      ),
      body: const Center(
        child: Text('Welcome to VX Code'),
      ),
    );
  }
}
