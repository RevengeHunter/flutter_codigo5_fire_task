import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  List<QueryDocumentSnapshot> docs = [];
  List<Map<String, dynamic>> myTasks = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Mis Tareas:",
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              Expanded(
                flex: 2,
                // child: FutureBuilder(
                //   future: _taskCollection.get(),
                //   builder: (BuildContext context, AsyncSnapshot snap) {
                //     if (snap.hasData) {
                //       List<Map<String, dynamic>> tasks = [];
                //       QuerySnapshot collection = snap.data;
                //       collection.docs.forEach((element) {
                //         Map<String, dynamic> myMap = element.data() as Map<String, dynamic>;
                //         myMap["id"] = element.id;
                //         tasks.add(myMap);
                //       });
                //
                //       print(snap.data);
                //       return ListView.builder(
                //         itemCount: tasks.length,
                //         itemBuilder: (BuildContext context, int index) {
                //           return ListTile(
                //             title: Text(
                //               tasks[index]["title"],
                //             ),
                //           );
                //         },
                //       );
                //     }
                //     return Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   },
                // ),
                child: ListView.builder(
                  itemCount: myTasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    DateTime dateTime =
                        (myTasks[index]["create_date"] as Timestamp).toDate();

                    return ListTile(
                      title: Text(
                        myTasks[index]["title"],
                      ),
                      subtitle: Text(
                          "Estado: ${myTasks[index]["descripcion"]} / Fecha: $dateTime"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _taskCollection
                              .doc(myTasks[index]["id"])
                              .delete()
                              .whenComplete(() {
                            print(
                                "Se elimino documento ${myTasks[index]["id"]}");
                            setState(() {});
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        myTasks = [];
                        _taskCollection.get().then(
                          (QuerySnapshot value) {
                            docs = value.docs;
                            docs.forEach((element) {
                              Map<String, dynamic> myMap =
                                  element.data() as Map<String, dynamic>;
                              myMap["id"] = element.id;
                              myTasks.add(myMap);
                            });
                          },
                        ).whenComplete(
                          () {
                            setState(() {});
                          },
                        );
                      },
                      child: Text(
                        "Get Data",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _taskCollection.add({
                          "title": "Comprar Paneton San Jorge",
                          "descripcion": "Buscar en Plaza Vea"
                        }).then((value) {
                          print(value.id);
                        }).catchError((error) {
                          print(error);
                        });
                      },
                      child: Text("Create Document!"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _taskCollection.doc("Uc0GJ0hH1P5CSdSHbjw2").update(
                          {
                            "title": "Comprar Panetones",
                            "descripcion": "Buscar en Tiendas Makro"
                          },
                        ).whenComplete(
                          () {
                            print("Update Completado");
                          },
                        ).catchError(
                          (error) {
                            print(error);
                          },
                        );
                      },
                      child: Text(
                        "Update Document",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _taskCollection
                            .doc("Uc0GJ0hH1P5CSdSHbjw2")
                            .delete()
                            .whenComplete(
                          () {
                            print("Delete Completado");
                          },
                        ).catchError(
                          (error) {
                            print(error);
                          },
                        );
                      },
                      child: Text(
                        "Delete Document",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _taskCollection.doc("micodigopersonalizadoEdRtF").set(
                          {
                            "title": "Ir al cine",
                            "status": false,
                            "create_date": DateTime.now(),
                          },
                        ).whenComplete(
                          () {
                            print("Create 2 Completado");
                          },
                        ).catchError(
                          (error) {
                            print(error);
                          },
                        );
                      },
                      child: Text(
                        "Create 2 Document",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
