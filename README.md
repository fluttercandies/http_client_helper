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
              millisecondsDelay: 1000,
              retries: 10)
          .then((response) {
        setState(() {
          msg = response.body;
        });
      });
    } on OperationCanceledError catch (e) {
      setState(() {
        msg = "cancel";
      });
    } catch (e) {

    }
```
Please see the example app of this plugin for a full example.