import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http_client_helper/http_client_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'http client helper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CancellationToken? cancellationToken;
  String msg = "";

  void request() async {
    var url = "https://api.tuchong.com/feed-app";
    //url = "https://google.com";
    setState(() {
      msg = "begin request";
    });
    cancellationToken = new CancellationToken();
    try {
      await HttpClientHelper.get(
        url,
        cancelToken: cancellationToken,
        timeRetry: Duration(milliseconds: 100),
        retries: 3,
        timeLimit: Duration(seconds: 5),
      ).then((response) {
        setState(() {
          msg = response?.body ?? "";
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
  }

  void cancel() {
    cancellationToken?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(onPressed: request, child: Text("Requset")),
              TextButton(onPressed: cancel, child: Text("Cancel"))
            ],
          ),
          Expanded(child: Text(msg))
        ],
      ),
    );
  }
}
