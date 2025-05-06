import 'package:flutter/material.dart';
import 'package:reusables/extensions/sizedbox_extension.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final Widget child;
  final double? verticalSpacing;

  /// This widget uses [TextTheme.displayMedium] for the label text style.
  /// It has a default font size of 16 and a default color of [colorScheme.onSurface].
  /// It has a default vertical spacing of 10 between the label and the child widget.
  /// The [child] widget is displayed below the label.
  const LabelWidget({
    super.key,
    required this.child,
    required this.label,
    this.verticalSpacing,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 0,
      children: [
        Text(
          label,
          style: textTheme.displayMedium!.copyWith(
            color: colorScheme.onSurface,
            fontSize: 16,
          ),
        ),
        (verticalSpacing ?? 10).height,
        child,
      ],
    );
  }
}
