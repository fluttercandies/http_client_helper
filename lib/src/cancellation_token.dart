import 'dart:async';

//Cancellation token to cancel future in dart
class CancellationToken {
  /// list to store complter future
  final List<Completer<dynamic>> _completers = <Completer<dynamic>>[];

  ///cancel error
  OperationCanceledError? _cancelError;

  /// whether has canceled
  bool get isCanceled {
    return _cancelError != null;
  }

  /// if request have been canceled, save the cancel Error.
  OperationCanceledError? get cancelError => _cancelError;

  /// cancel operation
  void cancel([String? msg]) {
    _cancelError = OperationCanceledError(msg ?? 'cancel this token');
    if (_completers.isNotEmpty) {
      _completers
          // ignore: avoid_function_literals_in_foreach_calls
          .forEach((Completer<dynamic> e) => e.completeError(cancelError!));
    }
  }

  /// add a [completer] to this token
  void _addCompleter(Completer<dynamic> completer) {
    if (isCanceled) {
      completer.completeError(_cancelError!);
      _completers.remove(completer);
    } else {
      if (!_completers.contains(completer)) {
        _completers.add(completer);
      }
    }
  }

  /// remove a [completer] from this token
  void _removeCompleter(Completer<dynamic> completer) {
    _completers.remove(completer);
  }

  //check whether it has canceled, yes ,throw
  void throwIfCancellationRequested() {
    if (isCanceled) {
      throw OperationCanceledError('this token has aleady canceled');
    }
  }
}

class OperationCanceledError extends Error {
  OperationCanceledError(this.msg);
  final String msg;
}

class CancellationTokenSource {
  static Future<T> register<T>(
      CancellationToken? cancelToken, Future<T> future) {
    if (cancelToken != null && !cancelToken.isCanceled) {
      final Completer<T> completer = Completer<T>();
      cancelToken._addCompleter(completer);
      return Future.any(<Future<T>>[completer.future, future])
          .then<T>((T result) async {
        cancelToken._removeCompleter(completer);
        return result;
      }).catchError((Object error) {
        cancelToken._removeCompleter(completer);
      });
    } else {
      return future;
    }
  }
}
