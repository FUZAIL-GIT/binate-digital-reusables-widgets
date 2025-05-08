import 'package:flutter/material.dart';

typedef PaginationFetcher<T> =
    Future<List<T>> Function({required int page, required int limit});

class PageState<T> {
  final List<T> items;
  final int currentPage;
  final bool isInitialLoading;
  final bool isLoadingNextPage;
  final bool hasMore;

  PageState({
    required this.items,
    required this.currentPage,
    required this.isInitialLoading,
    required this.isLoadingNextPage,
    required this.hasMore,
  });
}

typedef PaginationBuilder<T> =
    Widget Function(
      BuildContext context,
      List<T> items,
      PageState<T> state,
      ScrollController controller,
    );

class PaginationWrapper<T> extends StatefulWidget {
  final PaginationBuilder<T> builder;
  final PaginationFetcher<T> fetchData;
  final int pageSize;
  final double loadMoreOffset;

  const PaginationWrapper({
    super.key,
    required this.builder,
    required this.fetchData,
    this.pageSize = 20,
    this.loadMoreOffset = 200.0,
  });

  @override
  State<PaginationWrapper<T>> createState() => _PaginationWrapperState<T>();
}

class _PaginationWrapperState<T> extends State<PaginationWrapper<T>> {
  final List<T> _items = [];
  final ScrollController _controller = ScrollController();

  int _currentPage = 1;
  bool _isInitialLoading = false;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadInitial();
    _controller.addListener(_onScroll);
  }

  Future<void> _loadInitial() async {
    setState(() => _isInitialLoading = true);
    final data = await widget.fetchData(
      page: _currentPage,
      limit: widget.pageSize,
    );
    setState(() {
      _items.addAll(data);
      _hasMore = data.length == widget.pageSize;
      _isInitialLoading = false;
      _currentPage++;
    });
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;
    setState(() => _isLoading = true);
    final data = await widget.fetchData(
      page: _currentPage,
      limit: widget.pageSize,
    );
    setState(() {
      _items.addAll(data);
      _hasMore = data.length == widget.pageSize;
      _isLoading = false;
      _currentPage++;
    });
  }

  void _onScroll() {
    if (_controller.position.pixels >=
            _controller.position.maxScrollExtent - widget.loadMoreOffset &&
        !_isLoading &&
        _hasMore) {
      _loadMore();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _items,
      PageState<T>(
        items: _items,
        currentPage: _currentPage,
        isInitialLoading: _isInitialLoading,
        isLoadingNextPage: _isLoading,
        hasMore: _hasMore,
      ),
      _controller,
    );
  }
}
