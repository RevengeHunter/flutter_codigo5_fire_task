import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_fire_task/models/task_model.dart';
import 'package:flutter_codigo5_fire_task/ui/general/colors.dart';
import 'package:flutter_codigo5_fire_task/ui/widgets/item_task_widget.dart';

import '../ui/widgets/form_task_widget.dart';
import '../ui/widgets/textfield_widget.dart';

class HomeTaskPage extends StatefulWidget {
  @override
  State<HomeTaskPage> createState() => _HomeTaskPageState();
}

class _HomeTaskPageState extends State<HomeTaskPage> {
  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  final TextEditingController _searchController = TextEditingController();

  String key = "";

  _updateTask() {
    _taskCollection
        .doc(key)
        .update({"finished": true})
        .then((value) {})
        .whenComplete(() {
          Navigator.pop(context);
        });
  }

  showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kBrandPrimaryColor,
          contentPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "¿Desea finalizar esta tarea?",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: kFontPrimaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _updateTask();
                      },
                      child: Text(
                        "Finalizar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        primary: Color(0xff02c39a),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showCreateDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: FormTaskWidget(),
        );
      },
    );
  }

  List<TaskModel> taskModelList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      floatingActionButton: Material(
        color: kFontPrimaryColor,
        borderRadius: BorderRadius.circular(14.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.0),
          focusColor: Colors.yellow,
          hoverColor: Colors.redAccent,
          splashColor: Colors.white,
          highlightColor: Colors.blue,
          //overlayColor: Colors.white,
          onTap: () {
            showCreateDialog();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              //color: kFontPrimaryColor,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Text(
                  "Nueva Tarea",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.027),
                    blurRadius: 12,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Bienvenido, Ramón"),
                    Row(
                      children: [
                        Text(
                          "Mis Tareas",
                          style: TextStyle(
                            height: 1.1,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                            color: kFontPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextfieldWidget(
                      hintText: "Buscar Tareas",
                      icon: Icons.search,
                      textEditingController: _searchController,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Todas mis Tareas",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: kFontPrimaryColor.withOpacity(0.9),
                    ),
                  ),
                  StreamBuilder(
                    stream: _taskCollection.orderBy("finished").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snap) {
                      if (snap.hasData) {
                        QuerySnapshot collections = snap.data;
                        List<QueryDocumentSnapshot> docs = collections.docs;

                        // List<Map<String, dynamic>> docsMap = docs.map((e) {
                        //   Map<String, dynamic> myMap =
                        //       e.data() as Map<String, dynamic>;
                        //   myMap["id"] = e.id;
                        //   return myMap;
                        // }).toList();

                        taskModelList = docs.map((e) {
                          TaskModel task = TaskModel.fromJson(
                              e.data() as Map<String, dynamic>);
                          task.id = e.id;
                          return task;
                        }).toList();

                        return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          // clipBehavior: Clip.hardEdge,
                          itemCount: taskModelList.length,
                          itemBuilder: (context, index) {
                            return ItemTaskWidget(
                              taskModel: taskModelList[index],
                              onFinished: () {
                                key = taskModelList[index].id??"";
                                showUpdateDialog(context);
                              },
                            );
                          },
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
