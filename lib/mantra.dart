import 'package:flutter/material.dart';
import 'dart:async';

class Mantra extends StatefulWidget {
  const Mantra({super.key});

  @override
  State<Mantra> createState() => _MantraState();
}

class _MantraState extends State<Mantra> {
  final List<String> _mantras = [
    "Stay calm and breathe.",
    "This too shall pass.",
    "You are enough.",
    "Breathe in peace, breathe out stress.",
    "Focus on the present moment.",
    "Let go of what you cannot control.",
  ];

  String _currentMantra = "Don't Panic";
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startMantraTimer();
  }

  void _startMantraTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentMantra = _mantras[(timer.tick - 1) % _mantras.length];
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _currentMantra,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
