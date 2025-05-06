import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AsyncButton<T> extends StatefulWidget {
  final Future<T> Function() future;
  final void Function(T result)? onSuccess;
  final void Function(dynamic error)? onError;
  final String beforeLabel;
  final String afterLabel;
  final Color color;
  final Color labelColor;
  final Duration animationDuration;
  final bool hapticeFeedback;
  final bool? initialState;

  const AsyncButton({
    super.key,
    required this.future,
    required this.beforeLabel,
    required this.afterLabel,
    this.onSuccess,
    this.onError,
    this.hapticeFeedback = true,
    this.color = Colors.blue,
    this.labelColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 300),
    this.initialState = false,
  });

  @override
  AsyncButtonState<T> createState() => AsyncButtonState<T>();
}

class AsyncButtonState<T> extends State<AsyncButton<T>> {
  late bool isToggled;
  bool lastSuccessfulState = false;

  @override
  void initState() {
    isToggled = widget.initialState ?? false;
    super.initState();
  }

  void _handleTap() {
    if (widget.hapticeFeedback) {
      HapticFeedback.lightImpact();
    }

    // Instantly update UI
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
          log("Error in AsyncAnimatedButton: $error", stackTrace: stackTrace);
          widget.onError?.call(error);

          // On error, revert to last successful state
          setState(() {
            isToggled = lastSuccessfulState;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 7),
        decoration: BoxDecoration(
          color: isToggled ? Colors.transparent : widget.color,
          borderRadius: BorderRadius.circular(260),
          border: Border.all(color: widget.color, width: 2),
          boxShadow:
              isToggled
                  ? null
                  : [
                    BoxShadow(
                      color: colorScheme.onSurface.withValues(alpha: 0.15),
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                    ),
                  ],
        ),
        child: Text(
          isToggled ? widget.afterLabel : widget.beforeLabel,
          style: textTheme.bodyMedium!.copyWith(
            color: isToggled ? widget.color : widget.labelColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
