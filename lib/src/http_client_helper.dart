import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http_client_helper/src/cancellation_token.dart';
import 'package:http_client_helper/src/retry_helper.dart';

class HttpClientHelper {
  static Client _httpClient = Client();
  static Client get httpClient => _httpClient;
  void set(Client value) {
    _httpClient = value;
  }

  //http get with cancel, delay try again
  static Future<Response> get(url,
      {Map<String, String> headers,
      CancellationToken cancelToken,
      int retries = 3,
      Duration timeLimit,
      Duration timeRetry = const Duration(milliseconds: 100),
      OnTimeout onTimeout}) async {
    cancelToken?.throwIfCancellationRequested();
    return await RetryHelper.tryRun<Response>(() {
      return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.get(url, headers: headers)
              : _httpClient
                  .get(url, headers: headers)
                  .timeout(timeLimit, onTimeout: onTimeout));
    }, cancelToken: cancelToken, timeRetry: timeRetry, retries: retries);
  }

  //http post with cancel, delay try again
  static Future<Response> post(url,
      {Map<String, String> headers,
      body,
      Encoding encoding,
      CancellationToken cancelToken,
      int retries = 3,
      Duration timeLimit,
      Duration timeRetry = const Duration(milliseconds: 100),
      OnTimeout onTimeout}) async {
    cancelToken?.throwIfCancellationRequested();
    return await RetryHelper.tryRun<Response>(() {
      return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.post(url,
                  headers: headers, body: body, encoding: encoding)
              : _httpClient
                  .post(url, headers: headers, body: body, encoding: encoding)
                  .timeout(timeLimit, onTimeout: onTimeout));
    }, cancelToken: cancelToken, timeRetry: timeRetry, retries: retries);
  }

  //http head with cancel, delay try again
  static Future<Response> head(url,
      {Map<String, String> headers,
      CancellationToken cancelToken,
      int retries = 3,
      Duration timeLimit,
      Duration timeRetry = const Duration(milliseconds: 100),
      OnTimeout onTimeout}) async {
    cancelToken?.throwIfCancellationRequested();
    return await RetryHelper.tryRun<Response>(() {
      return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.head(url, headers: headers)
              : _httpClient
                  .head(url, headers: headers)
                  .timeout(timeLimit, onTimeout: onTimeout));
    }, cancelToken: cancelToken, timeRetry: timeRetry, retries: retries);
  }

  //http put with cancel, delay try again
  static Future<Response> put(url,
      {Map<String, String> headers,
      body,
      Encoding encoding,
      CancellationToken cancelToken,
      int retries = 3,
      Duration timeLimit,
      Duration timeRetry = const Duration(milliseconds: 100),
      OnTimeout onTimeout}) async {
    cancelToken?.throwIfCancellationRequested();
    return await RetryHelper.tryRun<Response>(() {
      return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.put(url,
                  headers: headers, body: body, encoding: encoding)
              : _httpClient
                  .put(url, headers: headers, body: body, encoding: encoding)
                  .timeout(timeLimit, onTimeout: onTimeout));
    }, cancelToken: cancelToken, timeRetry: timeRetry, retries: retries);
  }

  //http patch with cancel, delay try again
  static Future<Response> patch(url,
      {Map<String, String> headers,
      body,
      Encoding encoding,
      CancellationToken cancelToken,
      int retries = 3,
      Duration timeLimit,
      Duration timeRetry = const Duration(milliseconds: 100),
      OnTimeout onTimeout}) async {
    cancelToken?.throwIfCancellationRequested();
    return await RetryHelper.tryRun<Response>(() {
      return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.patch(url,
                  headers: headers, body: body, encoding: encoding)
              : _httpClient
                  .patch(url, headers: headers, body: body, encoding: encoding)
                  .timeout(timeLimit, onTimeout: onTimeout));
    }, cancelToken: cancelToken, timeRetry: timeRetry, retries: retries);
  }

  //http delete with cancel, delay try again
  static Future<Response> delete(url,
      {Map<String, String> headers,
      CancellationToken cancelToken,
      int retries = 3,
      Duration timeLimit,
      Duration timeRetry = const Duration(milliseconds: 100),
      OnTimeout onTimeout}) async {
    cancelToken?.throwIfCancellationRequested();
    return await RetryHelper.tryRun<Response>(() {
      return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.delete(url, headers: headers)
              : _httpClient
                  .delete(url, headers: headers)
                  .timeout(timeLimit, onTimeout: onTimeout));
    }, cancelToken: cancelToken, timeRetry: timeRetry, retries: retries);
  }

  //http read with cancel, delay try again
  static Future<String> read(url,
      {Map<String, String> headers,
      CancellationToken cancelToken,
      int retries = 3,
      Duration timeLimit,
      Duration timeRetry = const Duration(milliseconds: 100),
      OnTimeout onTimeout}) async {
    cancelToken?.throwIfCancellationRequested();
    return await RetryHelper.tryRun<String>(() {
      return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.read(url, headers: headers)
              : _httpClient
                  .read(url, headers: headers)
                  .timeout(timeLimit, onTimeout: onTimeout));
    }, cancelToken: cancelToken, timeRetry: timeRetry, retries: retries);
  }

  //http readBytes with cancel, delay try again
  static Future<Uint8List> readBytes(url,
      {Map<String, String> headers,
      CancellationToken cancelToken,
      int retries = 3,
      Duration timeLimit,
      Duration timeRetry = const Duration(milliseconds: 100),
      OnTimeout onTimeout}) async {
    cancelToken?.throwIfCancellationRequested();
    return await RetryHelper.tryRun<Uint8List>(() {
      return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.readBytes(url, headers: headers)
              : _httpClient
                  .readBytes(url, headers: headers)
                  .timeout(timeLimit, onTimeout: onTimeout));
    }, cancelToken: cancelToken, timeRetry: timeRetry, retries: retries);
  }

  //http send with cancel, delay try again
  static Future<StreamedResponse> send(BaseRequest request,
      {CancellationToken cancelToken,
      int retries = 3,
      Duration timeLimit,
      Duration timeRetry = const Duration(milliseconds: 100),
      OnTimeout onTimeout}) async {
    cancelToken?.throwIfCancellationRequested();
    return await RetryHelper.tryRun<StreamedResponse>(() {
      return CancellationTokenSource.register(
          cancelToken,
          timeLimit == null
              ? _httpClient.send(request)
              : _httpClient
                  .send(request)
                  .timeout(timeLimit, onTimeout: onTimeout));
    }, cancelToken: cancelToken, timeRetry: timeRetry, retries: retries);
  }

  //http close
  static void close() {
    _httpClient.close();
  }
}

typedef OnTimeout = FutureOr<dynamic> Function();
