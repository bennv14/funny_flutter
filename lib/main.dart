import 'package:flutter/material.dart';

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
      home: const SpendingTabPreview(),
    );
  }
}

class SpendingTabPreview extends StatefulWidget {
  const SpendingTabPreview({Key? key}) : super(key: key);

  @override
  State<SpendingTabPreview> createState() => _SpendingTabPreviewState();
}

class _SpendingTabPreviewState extends State<SpendingTabPreview> {
  int _currentItem = 1; // The original preview starts with item 1 selected
  final int _totalItems = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SpendingTab Preview"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Đây là widget được convert từ Jetpack Compose:',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 350, // Like the preview width = 400.dp
              height: 60, // Like the preview height = 100.dp, adjusted for looks
              child: SpendingTab(
                totalItems: _totalItems,
                currentItem: _currentItem,
                onValueChange: (index) {
                  setState(() {
                    _currentItem = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Tab hiện tại: $_currentItem',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}


/// This is the Flutter equivalent of the SpendingTab Composable.
class SpendingTab extends StatelessWidget {
  final int totalItems;
  final int currentItem;
  final ValueChanged<int> onValueChange;
  final Duration animationDuration;

  const SpendingTab({
    Key? key,
    required this.totalItems,
    this.currentItem = 0,
    required this.onValueChange,
    this.animationDuration = const Duration(milliseconds: 100),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder is used to get the constraints of the parent widget,
    // similar to BoxWithConstraints in Compose.
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / totalItems;
        final animatedOffset = currentItem * itemWidth;

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
          child: Stack(
            children: [
              // This is the animated indicator that slides to the current tab.
              // AnimatedPositioned handles the animation implicitly when 'left' changes.
              AnimatedPositioned(
                duration: animationDuration,
                curve: Curves.linear,
                left: animatedOffset,
                top: 0,
                bottom: 0,
                child: Container(
                  width: itemWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                     borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              // This Row contains the tappable areas for each tab.
              Row(
                children: List.generate(totalItems, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onValueChange(index),
                      // Using a transparent container to make the entire area of the
                      // Expanded widget tappable.
                      child: Container(
                          color: Colors.transparent,
                          child: Center(
                              child: Text(
                                  'Tab ${index + 1}',
                                  style: TextStyle(
                                    color: currentItem == index
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onSurface,
                                  ),
                              ),
                          ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
