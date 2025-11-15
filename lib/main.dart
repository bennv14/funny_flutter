import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'config/dart_defines.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!DartDefines.hasSentryDsn) {
    runApp(const MyApp());
    return;
  }

  await SentryFlutter.init((options) {
    options.dsn = DartDefines.sentryDsn;
    options.release = '1.0.1';
  }, appRunner: () => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      throw TestCustomException(message: 'Test Custom Exception');
    } catch (exception, stackTrace) {
      Sentry.captureException(exception, stackTrace: stackTrace);
    }
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

class FullScreenPreview extends StatelessWidget {
  const FullScreenPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Full Screen Preview'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                exit(0);
              },
              child: const Text('Throw State Error'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestCustomException implements Exception {
  TestCustomException({required this.message});

  final String message;

  @override
  String toString() {
    return 'TestCustomException: $message';
  }
}