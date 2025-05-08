import 'package:binate_digital_reusable_widgets/components/animations/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnimatedSeperateListView extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool isLoading;
  final ScrollController? controller;
  const AnimatedSeperateListView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.padding,
    this.shrinkWrap = true,
    this.isLoading = false,
    this.physics,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Skeletonizer(
          ignoreContainers: true,
          ignorePointers: true,
          enabled: isLoading,
          child: ListView.separated(
            shrinkWrap: shrinkWrap,
            controller: controller,
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            itemCount: itemCount,
            physics: physics ?? const BouncingScrollPhysics(),
            separatorBuilder:
                (_, __) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 7.5),
                  child: FadeAnimationWidget(
                    duration: Duration(milliseconds: 900),
                    child: Divider(thickness: 0.5, color: Colors.grey),
                  ),
                ),
            itemBuilder: itemBuilder,
          ),
        )
        : AnimationLimiter(
          child: ListView.separated(
            shrinkWrap: shrinkWrap,
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            itemCount: itemCount,
            physics: physics ?? const BouncingScrollPhysics(),
            separatorBuilder:
                (_, __) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 7.5),
                  child: FadeAnimationWidget(
                    duration: Duration(milliseconds: 900),
                    child: Divider(thickness: 0.5, color: Colors.grey),
                  ),
                ),
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 450),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(child: itemBuilder(context, index)),
                ),
              );
            },
          ),
        );
  }
}
