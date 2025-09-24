/// Used for error handling in a functional way
sealed class Result<T, E> {
  const Result();

  /// Creates a successful Result containing a value
  factory Result.ok(T value) = Ok<T, E>;

  /// Creates a failed Result containing an error
  factory Result.err(E error) = Err<T, E>;

  /// Returns true if the result is Ok
  bool get isOk => this is Ok<T, E>;

  /// Returns true if the result is Err
  bool get isErr => this is Err<T, E>;

  /// Returns the contained Ok value, or null if it's an Err
  T? get ok => switch (this) {
        Ok(:final value) => value,
        Err() => null,
      };

  /// Returns the contained Err value, or null if it's Ok
  E? get err => switch (this) {
        Ok() => null,
        Err(:final error) => error,
      };

  /// Returns the contained Ok value
  /// Throws an exception if the value is an Err
  T unwrap() {
    return switch (this) {
      Ok(:final value) => value,
      Err(:final error) => throw Exception(error),
    };
  }

  /// Returns the contained Ok value
  /// Throws an exception with custom message if the value is an Err
  T expect<X>(X x) {
    return switch (this) {
      Ok(:final value) => value,
      Err() => throw Exception(x),
    };
  }

  /// Returns the contained Err value
  /// Throws an exception if the value is Ok
  E unwrapErr() {
    return switch (this) {
      Ok(:final value) => throw Exception('Called unwrapErr on an Ok value: $value'),
      Err(:final error) => error,
    };
  }

  /// Returns the contained Ok value or a provided default
  T unwrapOr(T defaultValue) {
    return switch (this) {
      Ok(:final value) => value,
      Err() => defaultValue,
    };
  }

  /// Returns the contained Ok value or computes it from a closure
  T unwrapOrElse(T Function(E error) fn) {
    return switch (this) {
      Ok(:final value) => value,
      Err(:final error) => fn(error),
    };
  }

  /// Maps a `Result<T, E>` to `Result<U, E>` by applying a function to the Ok value
  Result<U, E> map<U>(U Function(T value) fn) {
    return switch (this) {
      Ok(:final value) => Ok(fn(value)),
      Err(:final error) => Err(error),
    };
  }

  /// Maps a `Result<T, E>` to `Result<T, F>` by applying a function to the Err value
  Result<T, F> mapErr<F>(F Function(E error) fn) {
    return switch (this) {
      Ok(:final value) => Ok(value),
      Err(:final error) => Err(fn(error)),
    };
  }

  /// Maps a `Result<T, E>` to `Result<U, E>` by applying a function that returns a Result
  Result<U, E> andThen<U>(Result<U, E> Function(T value) fn) {
    return switch (this) {
      Ok(:final value) => fn(value),
      Err(:final error) => Err(error),
    };
  }

  /// Maps a `Result<T, E>` to `Result<T, F>` by applying a function to the Err value
  Result<T, F> orElse<F>(Result<T, F> Function(E error) fn) {
    return switch (this) {
      Ok(:final value) => Ok(value),
      Err(:final error) => fn(error),
    };
  }

  /// Returns res if the result is Ok, otherwise returns the Err value of self
  Result<U, E> and<U>(Result<U, E> res) {
    return switch (this) {
      Ok() => res,
      Err(:final error) => Err(error),
    };
  }

  /// Returns res if the result is Err, otherwise returns the Ok value of self
  Result<T, F> or<F>(Result<T, F> res) {
    return switch (this) {
      Ok(:final value) => Ok(value),
      Err() => res,
    };
  }

  /// Calls the provided closure with the Ok value (if Ok)
  Result<T, E> inspect(void Function(T value) fn) {
    if (this is Ok<T, E>) {
      fn((this as Ok<T, E>).value);
    }
    return this;
  }

  /// Calls the provided closure with the Err value (if Err)
  Result<T, E> inspectErr(void Function(E error) fn) {
    if (this is Err<T, E>) {
      fn((this as Err<T, E>).error);
    }
    return this;
  }

  /// Converts from `Result<T, E>` to `T?`
  T? okOrNull() => ok;

  /// Converts from `Result<T, E>` to `E?`
  E? errOrNull() => err;

  /// Pattern matching on Result
  R when<R>({
    required R Function(T value) ok,
    required R Function(E error) err,
  }) {
    return switch (this) {
      Ok(:final value) => ok(value),
      Err(:final error) => err(error),
    };
  }

  /// Pattern matching with optional handlers
  R? whenOrNull<R>({
    R Function(T value)? ok,
    R Function(E error)? err,
  }) {
    return switch (this) {
      Ok(:final value) when ok != null => ok(value),
      Err(:final error) when err != null => err(error),
      _ => null,
    };
  }

  /// Async operations support
  Future<Result<U, E>> mapAsync<U>(Future<U> Function(T value) fn) async {
    return switch (this) {
      Ok(:final value) => Ok(await fn(value)),
      Err(:final error) => Err(error),
    };
  }

  /// Async andThen operation
  Future<Result<U, E>> andThenAsync<U>(Future<Result<U, E>> Function(T value) fn) async {
    return switch (this) {
      Ok(:final value) => await fn(value),
      Err(:final error) => Err(error),
    };
  }
}

/// Represents a successful value
final class Ok<T, E> extends Result<T, E> {
  final T value;

  const Ok(this.value);

  @override
  String toString() => 'Ok($value)';

  @override
  bool operator ==(Object other) {
    return other is Ok<T, E> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

/// Represents an error value
final class Err<T, E> extends Result<T, E> {
  final E error;

  const Err(this.error);

  @override
  String toString() => 'Err($error)';

  @override
  bool operator ==(Object other) {
    return other is Err<T, E> && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

/// Extension methods for Iterable of Results
extension ResultIterableExtension<T, E> on Iterable<Result<T, E>> {
  /// Collects an iterable of Results into a single Result containing a List
  /// Returns Ok with all values if all are Ok, otherwise returns the first Err
  Result<List<T>, E> collect() {
    final values = <T>[];
    for (final result in this) {
      switch (result) {
        case Ok(:final value):
          values.add(value);
        case Err(:final error):
          return Err(error);
      }
    }
    return Ok(values);
  }

  /// Returns a new iterable with only the Ok values
  Iterable<T> whereOk() sync* {
    for (final result in this) {
      if (result.isOk) {
        yield result.unwrap();
      }
    }
  }

  /// Returns a new iterable with only the Err values
  Iterable<E> whereErr() sync* {
    for (final result in this) {
      if (result.isErr) {
        yield result.unwrapErr();
      }
    }
  }

  /// Partitions the results into two lists: Ok values and Err values
  (List<T>, List<E>) partition() {
    final oks = <T>[];
    final errs = <E>[];
    for (final result in this) {
      switch (result) {
        case Ok(:final value):
          oks.add(value);
        case Err(:final error):
          errs.add(error);
      }
    }
    return (oks, errs);
  }
}

/// Helper functions for working with Results
class ResultHelper {
  ResultHelper._();

  /// Wraps a function that might throw in a Result
  static Result<T, E> tryCatch<T, E>(
    T Function() fn, {
    required E Function(Object error, StackTrace stackTrace) onError,
  }) {
    try {
      return Ok(fn());
    } catch (error, stackTrace) {
      return Err(onError(error, stackTrace));
    }
  }

  /// Async version of tryCatch
  static Future<Result<T, E>> tryCatchAsync<T, E>(
    Future<T> Function() fn, {
    required E Function(Object error, StackTrace stackTrace) onError,
  }) async {
    try {
      return Ok(await fn());
    } catch (error, stackTrace) {
      return Err(onError(error, stackTrace));
    }
  }

  /// Converts a nullable value to a Result
  static Result<T, E> fromNullable<T, E>(T? value, E error) {
    return value != null ? Ok(value) : Err(error);
  }

  /// Combines two Results into a single Result containing a tuple
  static Result<(T1, T2), E> combine2<T1, T2, E>(
    Result<T1, E> r1,
    Result<T2, E> r2,
  ) {
    return switch ((r1, r2)) {
      (Ok(:final value), Ok(value: final v2)) => Ok((value, v2)),
      (Err(:final error), _) => Err(error),
      (_, Err(:final error)) => Err(error),
    };
  }

  /// Combines three Results into a single Result containing a tuple
  static Result<(T1, T2, T3), E> combine3<T1, T2, T3, E>(
    Result<T1, E> r1,
    Result<T2, E> r2,
    Result<T3, E> r3,
  ) {
    return switch ((r1, r2, r3)) {
      (Ok(:final value), Ok(value: final v2), Ok(value: final v3)) => Ok((value, v2, v3)),
      (Err(:final error), _, _) => Err(error),
      (_, Err(:final error), _) => Err(error),
      (_, _, Err(:final error)) => Err(error),
    };
  }
}
