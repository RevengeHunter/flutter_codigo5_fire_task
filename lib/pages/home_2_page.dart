import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home2Page extends StatefulWidget {
  @override
  State<Home2Page> createState() => _Home2PageState();
}

class _Home2PageState extends State<Home2Page> {
  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  int count = 0;

  StreamController _myStreamController = StreamController.broadcast();

  @override
  initState() {
    super.initState();
    // Stream<String> myStream = Stream.fromFuture(getFullName());
    // myStream.listen((event) {
    //   print("ssssss $event");
    // }, onDone: (){
    //   print("ON DONE!!!!!!");
    // });

    // _myStreamController.stream.listen((event) {
    //   print("ESCUCHANDO 1:::: $event");
    // }, onDone: (){
    //   print("TERMINÉ DE ESCUCHAR:::::");
    // },);
  }

  //async* se esta realizando enfasis en un stream
  getData() async* {}

  Stream<int> countDownStream() async* {
    for (int i = 10; 0 <= i; i--) {
      await Future.delayed(Duration(seconds: 2));
      yield i;
    }
  }

  Future<String> getFullName() async {
    return Future.delayed(Duration(seconds: 5), () {
      return "Elvis Barrionuevo";
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _myStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    // countDownStream().listen((event) {
    //   print(event);
    // }, onDone: () {
    //   print("Stream finalizado");
    // }, onError: (error) {
    //   print("Hubo un error");
    // });

    // _myStreamController.stream.listen((event) {
    //   print("ESCUCHANDO 2:::: $event");
    // }, onDone: (){
    //   print("TERMINÉ DE ESCUCHAR:::::");
    // },);

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _myStreamController.stream,
          builder: (BuildContext context, AsyncSnapshot snap){
            if(snap.hasData){
              print(snap.data);
              int data = snap.data;
              return Text(
                "Hola ($data)",
                style: TextStyle(
                  fontSize: 16,
                ),
              );
            }
            return Text("x",);
          },
        ),
      ),
      // body: StreamBuilder(
      //   stream: _taskCollection.snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot snap){
      //     if(snap.hasData){
      //       QuerySnapshot collections = snap.data;
      //       print(collections.docs.length);
      //     }
      //     return Text("Hola");
      //   },
      // ),

      // body: StreamBuilder(
      //   stream: countDownStream(),
      //   builder: (BuildContext context, AsyncSnapshot snap) {
      //     print(snap);
      //     if (snap.hasData) {
      //       return Center(
      //         child: Text(
      //           snap.data.toString(),
      //           style: TextStyle(
      //             fontSize: 40.0,
      //           ),
      //         ),
      //       );
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          count++;
          _myStreamController.add(count);
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: _myStreamController.stream,
              builder: (BuildContext context, AsyncSnapshot snap){
                if(snap.hasData){
                  print(snap.data);
                  int data = snap.data;
                  return Text(
                    data.toString(),
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  );
                }
                return Text("x",);
              },
            ),
          ],
        ),
      ),
    );
  }
}
