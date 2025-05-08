import 'package:binate_digital_reusable_widgets/components/listview/primary_animated_list.dart';
import 'package:flutter/material.dart';

class AnimatedListView extends StatelessWidget {
  const AnimatedListView({super.key});
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
      appBar: AppBar(title: const Text('Animated List View')),
      body: PrimaryAnimatedList(
        isLoading: false,
        children: List.generate(
          10,
          (index) => ListTile(
            title: Text('Item $index'),
            subtitle: Text('Subtitle $index'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Handle delete action
              },
            ),
          ),
        ),
      ),
    );
  }
}
