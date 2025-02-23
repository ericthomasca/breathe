import 'package:flutter/material.dart';
import 'breathing.dart';
import 'mantra.dart';

void main() {
  runApp(const DontPanicApp());
}

class DontPanicApp extends StatelessWidget {
  const DontPanicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Don't Panic",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(
        title: "Don't Panic",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  // Define pages for bottom nav
  final List<Widget> _pages = [
    const Breathing(),
    const Mantra(),
    // Add pages here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.air),
            label: "Breathe",
          ),
          NavigationDestination(
            icon: Icon(Icons.psychology),
            label: "Mantra",
          )
          // Add nav bar items here
        ],
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
