import 'package:binate_digital_reusable_widgets/wrappers/pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';

class InfiniteScrollingPagination extends StatelessWidget {
  const InfiniteScrollingPagination({super.key});
  Future<List<String>> fetchPage({
    required int page,
    required int limit,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(limit, (i) => 'Item ${i + 1 + (page - 1) * limit}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Infinite Scrolling Pagination')),
      body: PaginationWrapper<String>(
        fetchData: fetchPage,
        builder: (context, items, state, controller) {
          return ListView.builder(
            controller: controller,
            itemCount: items.length + (state.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == items.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return ListTile(title: Text(items[index]));
            },
          );
        },
      ),
    );
  }
}
