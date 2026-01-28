import 'package:flutter/material.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize:MainAxisSize.min,
          children: const [
            _Dot(),
            SizedBox(width: 4),
            _Dot(delay : 200),
            SizedBox(width: 4),
            _Dot(delay : 400),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  final int delay;
  const _Dot({this.delay = 0});

  @override 
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    Future.delayed(
      Duration(milliseconds: widget.delay),
      _controller.forward,
      );
    }

    @override
    Widget build(BuildContext context) {
      return FadeTransition(
        opacity: _controller,
        child: const Text("•", style: TextStyle(fontSize: 24)),
        );  
      }

    @override 
    void dispose() {
      _controller.dispose();
      super.dispose();
    }
  }