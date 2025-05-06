import 'package:flutter/material.dart';

enum SlideDirection { leftToRight, rightToLeft, topToBottom, bottomToTop }

class SlideAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final SlideDirection direction;
  final double offset; // New parameter for customizable offset

  const SlideAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 1), // Default duration of 1 second
    this.direction =
        SlideDirection.rightToLeft, // Default slide from right to left
    this.offset = 1.0, // Default offset value
  });

  @override
  SlideAnimationWidgetState createState() => SlideAnimationWidgetState();
}

class SlideAnimationWidgetState extends State<SlideAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    Offset beginOffset;
    switch (widget.direction) {
      case SlideDirection.leftToRight:
        beginOffset = Offset(-widget.offset, 0.0);
        break;
      case SlideDirection.rightToLeft:
        beginOffset = Offset(widget.offset, 0.0);
        break;
      case SlideDirection.topToBottom:
        beginOffset = Offset(0.0, -widget.offset);
        break;
      case SlideDirection.bottomToTop:
        beginOffset = Offset(0.0, widget.offset);
        break;
    }

    _offsetAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Trigger the slide-in animation after the widget is fully loaded
    Future.delayed(Duration.zero, () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _offsetAnimation, child: widget.child);
  }
}
