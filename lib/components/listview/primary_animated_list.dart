import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrimaryAnimatedList extends StatelessWidget {
  final List<Widget> children;
  final Duration? duration;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final CrossAxisAlignment? crossAxisAlignment;
  final ScrollController? controller;
  final double? spacing;
  final bool isLoading;
  const PrimaryAnimatedList({
    super.key,
    required this.children,
    this.duration,
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.crossAxisAlignment,
    this.spacing,
    this.controller,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        spacing: spacing ?? 0.0,
        children:
            isLoading
                ? List.generate(
                  10,
                  (index) => Skeletonizer(child: children[index]),
                )
                : AnimationConfiguration.toStaggeredList(
                  duration: duration ?? Duration(milliseconds: 600),
                  childAnimationBuilder:
                      (widget) => SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(child: widget),
                      ),
                  children: children,
                ),
      ),
    );
  }
}
