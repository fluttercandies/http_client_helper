import 'package:http_client_helper/src/cancellation_token.dart';

class RetryHelper {
  RetryHelper._();
  //try again，after millisecondsDelay time
  static Future<T?> tryRun<T>(
    Future<T> Function() asyncFunc, {
    Duration timeRetry = const Duration(milliseconds: 100),
    int retries = 3,
    CancellationToken? cancelToken,
    bool Function()? throwThenExpction,
  }) async {
    int attempts = 0;
    while (attempts <= retries) {
      attempts++;
      //print("try at ${attempts} times");
      try {
        return await asyncFunc();
        // ignore: unused_catch_clause
      } on OperationCanceledError catch (error) {
        rethrow;
      } catch (error) {
        if (throwThenExpction != null && throwThenExpction()) {
          rethrow;
        }
        //twice time to retry
        //if (attempts > 1) millisecondsDelay *= 2;
      }
      //delay to retry
      //try {
      if (attempts < retries) {
        final Future<void> future = CancellationTokenSource.register(
            cancelToken, Future<void>.delayed(timeRetry, () {}));
        await future;
      }

      //} on OperationCanceledError catch (error) {
      //throw error;
      //}
    }
    return null;
  }
}
