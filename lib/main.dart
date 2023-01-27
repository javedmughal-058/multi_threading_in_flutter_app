import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi Threading',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Multi Threading'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;

  bool stop =false;

  @override
  void initState() {
    Isolate.beforeNextEvent;
    Isolate.spawn(isolateFunction, 5000,);
    super.initState();
  }

  void isolateFunction (int finalNum) {
    int _count = 0;
    for (int i = 0; i < finalNum; i++) {
      _count++;
      print("isolate: " +_count.toString());
      if(stop){
        print('Stop Working');
        Isolate.exit();
        // print('Stop Working');
        // break;

      }

    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.title),
      ),
      body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_count.toString()),
            ElevatedButton(
              child: const Text("Add"),
              onPressed: () async {
                _count++;
                setState(() {
                  stop = true;
                });
                print("Other Operation Performed");
              },
            ),


          ]
      )),
    );
  }
}



