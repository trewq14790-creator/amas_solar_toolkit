import 'package:flutter/material.dart';

void main() {
  runApp(const AmasSolarApp());
}

class AmasSolarApp extends StatelessWidget {
  const AmasSolarApp({super.key});

  @override
  Widget build(BuildContext nullContext) {
    return MaterialApp(
      title: 'AMAS Solar Toolkit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AMAS - أمس للطاقة الشمسية'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'أهلاً بك في تطبيق AMAS لتشخيص أعطال المحولات',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
