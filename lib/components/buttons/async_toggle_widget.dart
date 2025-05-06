import 'dart:developer';
import 'package:flutter/material.dart';

class AsyncToggleWidget<T> extends StatefulWidget {
  final Future<T> Function() future;
  final void Function(T result)? onSuccess;
  final void Function(dynamic error)? onError;
  final Widget before;
  final Widget after;
  final Duration animationDuration;
  final bool? initialState;

  const AsyncToggleWidget({
    super.key,
    required this.future,
    required this.before,
    required this.after,
    this.initialState = false,
    this.onSuccess,
    this.onError,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  AsyncToggleWidgetState<T> createState() => AsyncToggleWidgetState<T>();
}

class AsyncToggleWidgetState<T> extends State<AsyncToggleWidget<T>> {
  late bool isToggled;
  bool lastSuccessfulState = false;

  @override
  void initState() {
    isToggled = widget.initialState ?? false;
    super.initState();
  }

  void _handleTap() {
    log('Toggle tapped');

    setState(() {
      isToggled = !isToggled;
    });

    widget
        .future()
        .then((result) {
          lastSuccessfulState = isToggled;
          widget.onSuccess?.call(result);
        })
        .catchError((error, stackTrace) {
          log("Error in AsyncToggleWidget: $error", stackTrace: stackTrace);
          widget.onError?.call(error);

          setState(() {
            isToggled = lastSuccessfulState;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedSwitcher(
        duration: widget.animationDuration,
        transitionBuilder:
            (child, animation) =>
                FadeTransition(opacity: animation, child: child),
        child: isToggled ? widget.after : widget.before,
      ),
    );
  }
}
