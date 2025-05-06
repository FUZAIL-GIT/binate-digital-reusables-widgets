import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrimaryAnimatedList extends StatefulWidget {
  final List<Widget> children;
  final Duration? duration;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final CrossAxisAlignment? crossAxisAlignment;
  final double? verticalOffset;
  final double? horizontalOffset;
  final double? spacing;
  final bool isLoading;
  final Future<void> Function()? onNextPage;

  const PrimaryAnimatedList({
    super.key,
    required this.children,
    this.duration,
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.crossAxisAlignment,
    this.spacing,
    this.verticalOffset,
    this.horizontalOffset,
    this.isLoading = false,
    this.onNextPage,
  });

  @override
  State<PrimaryAnimatedList> createState() => _PrimaryAnimatedListState();
}

class _PrimaryAnimatedListState extends State<PrimaryAnimatedList> {
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

  @override
  Widget build(BuildContext context) {
    final listContent =
        widget.isLoading
            ? widget.children.map((e) => Skeletonizer(child: e)).toList()
            : AnimationConfiguration.toStaggeredList(
              duration: widget.duration ?? Duration(milliseconds: 600),
              childAnimationBuilder:
                  (child) => SlideAnimation(
                    verticalOffset: widget.verticalOffset,
                    horizontalOffset: widget.horizontalOffset,
                    child: FadeInAnimation(child: child),
                  ),
              children: widget.children,
            );

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment:
            widget.crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
        mainAxisSize: widget.mainAxisSize ?? MainAxisSize.max,
        children: [
          ...listContent,
          if (_isFetchingMore)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
