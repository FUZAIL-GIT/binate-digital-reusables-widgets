import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:reusables/components/animations/fade_animation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnimatedSeperateListView extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool isLoading;
  final Future<void> Function()? onNextPage;

  const AnimatedSeperateListView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.padding,
    this.shrinkWrap = true,
    this.isLoading = false,
    this.physics,
    this.onNextPage,
  });

  @override
  State<AnimatedSeperateListView> createState() =>
      _AnimatedSeperateListViewState();
}

class _AnimatedSeperateListViewState extends State<AnimatedSeperateListView> {
  final ScrollController _scrollController = ScrollController();
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isFetchingMore &&
        widget.onNextPage != null) {
      setState(() => _isFetchingMore = true);
      await widget.onNextPage!();
      if (mounted) setState(() => _isFetchingMore = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 7.5),
      child: FadeAnimationWidget(
        duration: Duration(milliseconds: 900),
        child: Divider(thickness: 0.5, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalCount =
        _isFetchingMore ? widget.itemCount + 1 : widget.itemCount;

    if (widget.isLoading) {
      return Skeletonizer(
        ignoreContainers: true,
        ignorePointers: true,
        enabled: widget.isLoading,
        child: ListView.separated(
          controller: _scrollController,
          shrinkWrap: widget.shrinkWrap,
          padding:
              widget.padding ??
              const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          itemCount: totalCount,
          physics: widget.physics ?? const BouncingScrollPhysics(),
          separatorBuilder: _separatorBuilder,
          itemBuilder: (context, index) {
            if (index >= widget.itemCount) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return widget.itemBuilder(context, index);
          },
        ),
      );
    }

    return AnimationLimiter(
      child: ListView.separated(
        controller: _scrollController,
        shrinkWrap: widget.shrinkWrap,
        padding:
            widget.padding ??
            const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        itemCount: totalCount,
        physics: widget.physics ?? const BouncingScrollPhysics(),
        separatorBuilder: _separatorBuilder,
        itemBuilder: (context, index) {
          if (index >= widget.itemCount) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 450),
            child: SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget.itemBuilder(context, index)),
            ),
          );
        },
      ),
    );
  }
}
