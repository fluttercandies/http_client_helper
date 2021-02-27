import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http_client_helper/src/cancellation_token.dart';
import 'package:http_client_helper/src/retry_helper.dart';

typedef OnTimeout<T> = FutureOr<T> Function();

class HttpClientHelper {
  static Client _httpClient = Client();

  static Client get httpClient => _httpClient;

  void set(Client value) {
    _httpClient = value;
  }

  // http get with cancel, delay try again
  static Future<Response?> get(
    String url, {
    Map<String, String>? headers,
    CancellationToken? cancelToken,
    int retries = 3,
    Duration? timeLimit,
    Duration timeRetry = const Duration(milliseconds: 100),
    OnTimeout<Response>? onTimeout,
  }) async {
    cancelToken?.throwIfCancellationRequested();
    final Uri uri = Uri.parse(url);
    return await RetryHelper.tryRun<Response>(
      () {
        return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.get(uri, headers: headers)
              : _httpClient
                  .get(uri, headers: headers)
                  .timeout(timeLimit, onTimeout: onTimeout),
        );
      },
      cancelToken: cancelToken,
      timeRetry: timeRetry,
      retries: retries,
    );
  }

  // http post with cancel, delay try again
  static Future<Response?> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    CancellationToken? cancelToken,
    int retries = 3,
    Duration? timeLimit,
    Duration? timeRetry = const Duration(milliseconds: 100),
    OnTimeout<Response>? onTimeout,
  }) async {
    cancelToken?.throwIfCancellationRequested();
    final Uri uri = Uri.parse(url);
    return await RetryHelper.tryRun<Response>(
      () {
        return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.post(
                  uri,
                  headers: headers,
                  body: body,
                  encoding: encoding,
                )
              : _httpClient
                  .post(uri, headers: headers, body: body, encoding: encoding)
                  .timeout(timeLimit, onTimeout: onTimeout),
        );
      },
      cancelToken: cancelToken,
      timeRetry: timeRetry,
      retries: retries,
    );
  }

  // http head with cancel, delay try again
  static Future<Response?> head(
    String url, {
    Map<String, String>? headers,
    CancellationToken? cancelToken,
    int retries = 3,
    Duration? timeLimit,
    Duration? timeRetry = const Duration(milliseconds: 100),
    OnTimeout<Response>? onTimeout,
  }) async {
    cancelToken?.throwIfCancellationRequested();
    final Uri uri = Uri.parse(url);
    return await RetryHelper.tryRun<Response>(
      () {
        return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.head(uri, headers: headers)
              : _httpClient
                  .head(uri, headers: headers)
                  .timeout(timeLimit, onTimeout: onTimeout),
        );
      },
      cancelToken: cancelToken,
      timeRetry: timeRetry,
      retries: retries,
    );
  }

  // http put with cancel, delay try again
  static Future<Response?> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    CancellationToken? cancelToken,
    int retries = 3,
    Duration? timeLimit,
    Duration? timeRetry = const Duration(milliseconds: 100),
    OnTimeout<Response>? onTimeout,
  }) async {
    cancelToken?.throwIfCancellationRequested();
    final Uri uri = Uri.parse(url);
    return await RetryHelper.tryRun<Response>(
      () {
        return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.put(
                  uri,
                  headers: headers,
                  body: body,
                  encoding: encoding,
                )
              : _httpClient
                  .put(uri, headers: headers, body: body, encoding: encoding)
                  .timeout(timeLimit, onTimeout: onTimeout),
        );
      },
      cancelToken: cancelToken,
      timeRetry: timeRetry,
      retries: retries,
    );
  }

  // http patch with cancel, delay try again
  static Future<Response?> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    CancellationToken? cancelToken,
    int retries = 3,
    Duration? timeLimit,
    Duration? timeRetry = const Duration(milliseconds: 100),
    OnTimeout<Response>? onTimeout,
  }) async {
    cancelToken?.throwIfCancellationRequested();
    final Uri uri = Uri.parse(url);
    return await RetryHelper.tryRun<Response>(
      () {
        return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.patch(
                  uri,
                  headers: headers,
                  body: body,
                  encoding: encoding,
                )
              : _httpClient
                  .patch(uri, headers: headers, body: body, encoding: encoding)
                  .timeout(timeLimit, onTimeout: onTimeout),
        );
      },
      cancelToken: cancelToken,
      timeRetry: timeRetry,
      retries: retries,
    );
  }

  // http delete with cancel, delay try again
  static Future<Response?> delete(
    String url, {
    Map<String, String>? headers,
    CancellationToken? cancelToken,
    int retries = 3,
    Duration? timeLimit,
    Duration? timeRetry = const Duration(milliseconds: 100),
    OnTimeout<Response>? onTimeout,
  }) async {
    cancelToken?.throwIfCancellationRequested();
    final Uri uri = Uri.parse(url);
    return await RetryHelper.tryRun<Response>(
      () {
        return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.delete(uri, headers: headers)
              : _httpClient
                  .delete(uri, headers: headers)
                  .timeout(timeLimit, onTimeout: onTimeout),
        );
      },
      cancelToken: cancelToken,
      timeRetry: timeRetry,
      retries: retries,
    );
  }

  // http read with cancel, delay try again
  static Future<String?> read(
    String url, {
    Map<String, String>? headers,
    CancellationToken? cancelToken,
    int retries = 3,
    Duration? timeLimit,
    Duration? timeRetry = const Duration(milliseconds: 100),
    OnTimeout<String>? onTimeout,
  }) async {
    cancelToken?.throwIfCancellationRequested();
    final Uri uri = Uri.parse(url);
    return await RetryHelper.tryRun<String>(
      () {
        return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.read(uri, headers: headers)
              : _httpClient
                  .read(uri, headers: headers)
                  .timeout(timeLimit, onTimeout: onTimeout),
        );
      },
      cancelToken: cancelToken,
      timeRetry: timeRetry,
      retries: retries,
    );
  }

  // http readBytes with cancel, delay try again
  static Future<Uint8List?> readBytes(
    String url, {
    Map<String, String>? headers,
    CancellationToken? cancelToken,
    int retries = 3,
    Duration? timeLimit,
    Duration? timeRetry = const Duration(milliseconds: 100),
    OnTimeout<Uint8List>? onTimeout,
  }) async {
    cancelToken?.throwIfCancellationRequested();
    final Uri uri = Uri.parse(url);
    return await RetryHelper.tryRun<Uint8List>(
      () {
        return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.readBytes(uri, headers: headers)
              : _httpClient
                  .readBytes(uri, headers: headers)
                  .timeout(timeLimit, onTimeout: onTimeout),
        );
      },
      cancelToken: cancelToken,
      timeRetry: timeRetry,
      retries: retries,
    );
  }

  // http send with cancel, delay try again
  static Future<StreamedResponse?> send(
    BaseRequest request, {
    CancellationToken? cancelToken,
    int retries = 3,
    Duration? timeLimit,
    Duration timeRetry = const Duration(milliseconds: 100),
    OnTimeout<StreamedResponse>? onTimeout,
  }) async {
    cancelToken?.throwIfCancellationRequested();
    return await RetryHelper.tryRun<StreamedResponse>(
      () {
        return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.send(request)
              : _httpClient
                  .send(request)
                  .timeout(timeLimit, onTimeout: onTimeout),
        );
      },
      cancelToken: cancelToken,
      timeRetry: timeRetry,
      retries: retries,
    );
  }

  // http close
  static void close() => _httpClient.close();
}
