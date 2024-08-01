import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanal Koçum',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color.fromRGBO(64, 135, 156, 1),
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

  void navigateToNewScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewScreen(
          name: controller.text,
          selectedClass: selectedClass,
        ),
      ),
    );
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
                  '8. Sınıf'
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
                onPressed: navigateToNewScreen,
                child: const Text('Devam Et'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  final String name;
  final String? selectedClass;

  const NewScreen({super.key, required this.name, required this.selectedClass});

  void showSchedule(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IntensitySelectionScreen(classLevel: selectedClass!),
      ),
    );
  }

  void showNotes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Ekran'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('İsim: $name', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Text('Sınıf: $selectedClass', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => showSchedule(context),
                child: const Text('Ders Programı'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => showNotes(context),
                child: const Text('Notlar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IntensitySelectionScreen extends StatelessWidget {
  final String classLevel;

  const IntensitySelectionScreen({super.key, required this.classLevel});

  void showSchedule(BuildContext context, String intensity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScheduleScreen(classLevel: classLevel, intensity: intensity),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoğunluk Seçimi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => showSchedule(context, 'Az Yoğun'),
              child: const Text('Az Yoğun'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => showSchedule(context, 'Çok Yoğun'),
              child: const Text('Çok Yoğun'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleScreen extends StatelessWidget {
  final String classLevel;
  final String intensity;

  ScheduleScreen({super.key, required this.classLevel, required this.intensity});

  final Map<String, Map<String, Map<String, List<String>>>> schedules = {
    '5. Sınıf': {
      'Az Yoğun': {
        '1. Gün': ['Türkçe'],
        '2. Gün': ['Matematik'],
        '3. Gün': ['Fen Bilimleri'],
        '4. Gün': ['Din Kültürü'],
        '5. Gün': ['İngilizce'],
        '6. Gün': ['Sosyal Bilgiler'],
        '7. Gün': [], // Haftada 1 gün boş
      },
      'Çok Yoğun': {
        '1. Gün': ['Türkçe'],
        '2. Gün': ['Matematik'],
        '3. Gün': ['Fen Bilimleri'],
        '4. Gün': ['Din Kültürü'],
        '5. Gün': ['İngilizce'],
        '6. Gün': ['Sosyal Bilgiler'],
        '7. Gün': [], // Haftada 1 gün boş
      },
    },
    '6. Sınıf': {
      'Az Yoğun': {
        '1. Gün': ['Türkçe'],
        '2. Gün': ['Matematik'],
        '3. Gün': ['Fen Bilimleri'],
        '4. Gün': ['Din Kültürü'],
        '5. Gün': ['İngilizce'],
        '6. Gün': ['Sosyal Bilgiler'],
        '7. Gün': [], // Haftada 1 gün boş
      },
      'Çok Yoğun': {
        '1. Gün': ['Türkçe', 'Fen Bilimleri'],
        '2. Gün': ['Matematik', 'Din Kültürü'],
        '3. Gün': ['İngilizce', 'Sosyal Bilgiler'],
        '4. Gün': ['Türkçe', 'Fen Bilimleri'],
        '5. Gün': ['Matematik', 'İngilizce'],
        '6. Gün': ['İngilizce', 'Sosyal Bilgiler'],
        '7. Gün': [], // Haftada 1 gün boş
      },
    },
    '7. Sınıf': {
      'Az Yoğun': {
        '1. Gün': ['Türkçe'],
        '2. Gün': ['Matematik'],
        '3. Gün': ['Fen Bilimleri'],
        '4. Gün': ['Din Kültürü'],
        '5. Gün': ['İngilizce'],
        '6. Gün': ['Sosyal Bilgiler'],
        '7. Gün': [], // Haftada 1 gün boş
      },
      'Çok Yoğun': {
        '1. Gün': ['Türkçe', 'Fen Bilimleri'],
        '2. Gün': ['Matematik', 'Din Kültürü'],
        '3. Gün': ['İngilizce', 'Sosyal Bilgiler'],
        '4. Gün': ['Türkçe', 'Fen Bilimleri'],
        '5. Gün': ['Matematik', 'İngilizce'],
        '6. Gün': ['İngilizce', 'Sosyal Bilgiler'],
        '7. Gün': [], // Haftada 1 gün boş
      },
    },
    '8. Sınıf': {
      'Az Yoğun': {
        '1. Gün': ['Türkçe'],
        '2. Gün': ['Matematik'],
        '3. Gün': ['Fen Bilimleri'],
        '4. Gün': ['Din Kültürü'],
        '5. Gün': ['İngilizce'],
        '6. Gün': ['İnkılap'],
        '7. Gün': [], // Haftada 1 gün boş
      },
      'Çok Yoğun': {
        '1. Gün': ['Türkçe', 'Fen Bilimleri'],
        '2. Gün': ['Matematik', 'Din Kültürü'],
        '3. Gün': ['İngilizce', 'Sosyal Bilgiler'],
        '4. Gün': ['Türkçe', 'Fen Bilimleri'],
        '5. Gün': ['Matematik', 'İngilizce'],
        '6. Gün': ['İngilizce', 'İnkılap'],
        '7. Gün': [], // Haftada 1 gün boş
      },
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$classLevel - $intensity Ders Programı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 7, // Haftanın 7 günü
          itemBuilder: (context, index) {
            String day = '${index + 1}. Gün';
            List<String>? subjects = schedules[classLevel]?[intensity]?[day];
            String subtitle = subjects == null || subjects.isEmpty ? 'Boş' : subjects.join(', ');

            return ListTile(
              title: Text(day),
              subtitle: Text(subtitle),
            );
          },
        ),
      ),
    );
  }
}

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<String> notes = [];
  TextEditingController noteController = TextEditingController();

  void addNote() {
    setState(() {
      notes.add(noteController.text);
      noteController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notlar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Notunuzu girin',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addNote,
              child: const Text('Not Ekle'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
