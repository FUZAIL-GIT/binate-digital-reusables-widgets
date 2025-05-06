import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryButton extends StatefulWidget {
  final String label;
  final Function() onTap;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderSide? borderSide;
  final Size? fixedSize;
  final double? borderRadius;
  final bool isExpanded;
  final bool isDisabled;
  final Function? onDisabledTap;
  final IconAlignment? iconAlignment;
  final bool hapticFeedback;

  /// This button uses [TextTheme.labelMedium] for the text style.
  ///
  /// It has a default height of 60 and a default border radius of 260.
  ///
  /// The button has a default background color of [colorScheme.primary].
  ///
  /// The button has a default text color of [colorScheme.onPrimary].
  ///
  /// The button has a default border radius of 260.
  ///
  /// The button has a default border side of [BorderSide.none].
  ///
  /// The button has a default fixed size of [Size.fromHeight(60)].
  ///
  /// The button has a default icon alignment of [IconAlignment.left].
  ///
  /// The button has a default haptic feedback of [true].
  ///
  /// The button has a default isExpanded of [true].
  ///
  /// The button has a default isDisabled of [false].
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderSide,
    this.fixedSize,
    this.borderRadius,
    this.isDisabled = false,
    this.onDisabledTap,
    this.iconAlignment,
    this.hapticFeedback = true,
    this.isExpanded = true,
  });

  @override
  PrimaryButtonState createState() => PrimaryButtonState();
}

class PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
      lowerBound: 0.8,
      upperBound: 1.0,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.reverse();
  }

  void _onTapUp(TapUpDetails details) async {
    if (widget.hapticFeedback) {
      HapticFeedback.lightImpact();
    }
    await Future.delayed(const Duration(milliseconds: 150)); // Small delay
    _controller.forward(); // Expand back after delay
    if (!widget.isDisabled) {
      widget.onTap();
    } else {
      widget.onDisabledTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      fixedSize: widget.fixedSize ?? Size.fromHeight(60),
      backgroundColor: widget.backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 260),
      ),
    );
    Widget child = Text(
      widget.label,
      style: textTheme.labelMedium!.copyWith(
        color: widget.textColor ?? colorScheme.onPrimary,
      ),
    );
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: widget.isDisabled ? 0.5 : 1,
      child: SizedBox(
        width: widget.isExpanded ? double.infinity : null,
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: AnimatedContainer(
              height: widget.fixedSize?.height ?? 60,
              width: widget.fixedSize?.width ?? double.infinity,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? colorScheme.primary,
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 260),
                border: Border.fromBorderSide(
                  widget.borderSide ?? BorderSide.none,
                ),
              ),
              child:
                  widget.icon != null
                      ? ElevatedButton.icon(
                        onPressed: null,
                        iconAlignment: widget.iconAlignment,
                        style: buttonStyle,
                        icon: widget.icon ?? const SizedBox.shrink(),
                        label: child,
                      )
                      : ElevatedButton(
                        onPressed: null,
                        style: buttonStyle,
                        child: child,
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
