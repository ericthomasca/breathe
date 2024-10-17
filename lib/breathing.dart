import 'package:flutter/material.dart';

class Breathing extends StatefulWidget {
  const Breathing({super.key});

  @override
  State<Breathing> createState() => _BreathingState();
}

class _BreathingState extends State<Breathing> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _radiusAnimation;

  // Init text and phase
  String _text = "Inhale";
  int _phase = 0;

  // Define phases and durations
  final List<String> _phases = ["Inhale", "Hold", "Exhale"];
  final List<Duration> _durations = [
    const Duration(seconds: 4), // Inhale
    const Duration(seconds: 5), // Hold
    const Duration(seconds: 7), // Exhale
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimationController();
    _animationController.forward();
  }

  void _initializeAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: _durations[_phase],
    );

    _radiusAnimation = Tween<double>(begin: 100.0, end: 150.0).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _advancePhase();
      }
    });
  }

  void _advancePhase() {
    setState(() {
      _phase = (_phase + 1) % _phases.length;
      _text = _phases[_phase];
      _animationController.duration = _durations[_phase];

      if (_phase == 0) {
        _animationController.forward(from: 0);
      } else if (_phase == 1) {
        _animationController.stop();
        _startHoldTimer();
      } else if (_phase == 2) {
        _animationController.reverse(from: 1);
        _startExhaleTimer();
      }
    });
  }

  void _startHoldTimer() {
    Future.delayed(_durations[1], () {
      if (mounted) {
        _advancePhase(); // Move to Exhale after Hold
      }
    });
  }

  void _startExhaleTimer() {
    Future.delayed(_durations[2], () {
      if (mounted) {
        _advancePhase(); // Move back to Inhale after Exhale
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: _radiusAnimation.value * 2,
                  height: _radiusAnimation.value * 2,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  _text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            );
          }),
    );
  }
}
