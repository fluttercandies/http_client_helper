import 'package:http_client_helper/src/cancellation_token.dart';

class RetryHelper {
  //try again，after millisecondsDelay time
  static Future<T?> tryRun<T>(
    Future<T> Function() asyncFunc, {
    Duration? timeRetry = const Duration(milliseconds: 100),
    int retries = 3,
    CancellationToken? cancelToken,
    bool Function()? throwWhenException,
  }) async {
    int attempts = 0;
    while (attempts <= retries) {
      attempts++;
      try {
        return await asyncFunc();
      } on OperationCanceledError catch (error) {
        throw error;
      } catch (error) {
        if (throwWhenException != null && throwWhenException()) {
          throw error;
        }
      }
      //delay to retry
      if (attempts < retries && timeRetry != null) {
        var future = CancellationTokenSource.register(
          cancelToken,
          Future.delayed(timeRetry),
        );
        await future;
      }
    }
    return null;
  }
}
