# http_client_helper

[![pub package](https://img.shields.io/pub/v/http_client_helper.svg)](https://pub.dartlang.org/packages/http_client_helper)

A Flutter plugin for http request with cancel and retry fuctions.

## Usage

To use this plugin, add `http_client_helper` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

``` dart
  cancellationToken = new CancellationToken();
      try {
        await HttpClientHelper.get(url,
                cancelToken: cancellationToken,
                timeRetry: Duration(milliseconds: 100),
                retries: 3,
                timeLimit: Duration(seconds: 5))
            .then((response) {
          setState(() {
            msg = response.body;
          });
        });
      } on TimeoutException catch (_) {
        setState(() {
          msg = "TimeoutException";
        });
      } on OperationCanceledError catch (_) {
        setState(() {
          msg = "cancel";
        });
      } catch (e) {
        setState(() {
          msg = "$e";
        });
      }
```
Please see the example app of this plugin for a full example.