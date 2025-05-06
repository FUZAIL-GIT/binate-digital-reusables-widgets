import 'package:flutter/material.dart';

class FadeAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 1), // Default duration of 1 second
  });

  @override
  FadeAnimationWidgetState createState() => FadeAnimationWidgetState();
}

class FadeAnimationWidgetState extends State<FadeAnimationWidget> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Trigger the fade-in after the widget is fully loaded
    Future.delayed(Duration.zero, () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity:
          _visible ? 1.0 : 0.0, // Fade to fully visible when _visible is true
      duration: widget.duration,
      curve: Curves.easeIn,
      child: widget.child,
    );
  }
}
