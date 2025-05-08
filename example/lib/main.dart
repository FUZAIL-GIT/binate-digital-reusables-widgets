import 'package:examples/pages/animated_list_view.dart';
import 'package:examples/pages/buttons.dart';
import 'package:examples/pages/infinite_scrolling_pagination.dart';
import 'package:flutter/material.dart';
import 'package:binate_digital_reusable_widgets/reusables.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Binate Digital',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> widgets = [
    InfiniteScrollingPagination(),
    Buttons(),
    AnimatedListView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Binate Digital Reusable Widgets')),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(widgets.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widgets[index]),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  widgets[index].toString().spacedFromCamelCase,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
