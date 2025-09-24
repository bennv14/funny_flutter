import 'package:funny_flutter/result.dart';

class Api {
  Future<String> getSuccess() async {
    return 'string';
  }

  Future<int> getError(int id) async {
    throw Exception('error $id');
  }
}

class Repo {
  final Api api;

  Repo({required this.api});

  Future<Result<String, Exception>> getString() async {
    return ResultHelper.tryCatchAsync(
      () async => await api.getSuccess(),
      onError: (e, _) => e as Exception,
    );
  }

  Future<Result<int, Exception>> getError(int id) async {
    return ResultHelper.tryCatchAsync(
      () async => await api.getError(id),
      onError: (e, _) => e as Exception,
    );
  }
}

void main() async {
  final repo = Repo(api: Api());

  // demo success
  final result = await repo.getString();

  final result2 = result.map(
    (value) => value.toUpperCase(),
  );

  // STRING
  print(result2);

  // demo error
  final result3 = await repo.getString();
  result3.expect('error');
  final result4 = await result3.andThenAsync(
    (value) async => await repo.getError(2),
  );

  print(result4);
  
}
