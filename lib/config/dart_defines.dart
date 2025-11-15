class DartDefines {
  const DartDefines._();

  /// Reads `SENTRY_DSN` from `--dart-define` or `--dart-define-from-file`.
  static const String sentryDsn = String.fromEnvironment('SENTRY_DSN');

  /// Whether a non-empty DSN was provided.
  static bool get hasSentryDsn => sentryDsn.isNotEmpty;
}


