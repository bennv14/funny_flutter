import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FullScreenPreview(),
    );
  }
}

class FullScreenPreview extends StatefulWidget {
  const FullScreenPreview({super.key});

  @override
  State<FullScreenPreview> createState() => _FullScreenPreviewState();
}

class _FullScreenPreviewState extends State<FullScreenPreview> {
  final GlobalKey _key = GlobalKey();
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _itemScrollController.scrollTo(
            index: 88,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: ScrollablePositionedList.builder(
          itemScrollController: _itemScrollController,
          itemCount: 100,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  key: index == 88 ? _key : null,
                  height: 100,
                  width: double.infinity,
                  color: Color(Random().nextInt(0xFFFFFFFF)),
                  child: Text('Item $index'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
