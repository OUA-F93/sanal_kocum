import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanal Kocum',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color.fromRGBO(
            64, 135, 156, 1), // Arka plan rengini değiştirin
      ),
      home: const MyHomePage(
        title: 'Sanal Koçum',
        backgroundColor: Color.fromRGBO(64, 135, 156, 1),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.backgroundColor,
  });

  final String title;
  final Color backgroundColor;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController controller;
  String text = "";
  String? selectedClass;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void printInfo() {
    print('İsim: ${controller.text}');
    print('Sınıf: $selectedClass');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Color.fromRGBO(64, 135, 156, 1)),
        ),
        backgroundColor: const Color.fromRGBO(64, 135, 156, 1),
      ),
      backgroundColor: widget.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 25.0),
                child: Image(
                  image: AssetImage("lib/images/app logo.jpg"),
                ),
              ),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'İsminizi girin',
                ),
                onSubmitted: (String value) {
                  setState(() {
                    text = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              DropdownButton<String>(
                value: selectedClass,
                hint: const Text('Kaçıncı sınıfsınız'),
                items: <String>[
                  '5. Sınıf',
                  '6. Sınıf',
                  '7. Sınıf',
                  '8. Sınıf',
                  '9. Sınıf',
                  '10. Sınıf',
                  '11. Sınıf',
                  '12. Sınıf'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedClass = newValue;
                  });
                },
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: printInfo,
                child: const Text('Bilgileri Yazdır'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
