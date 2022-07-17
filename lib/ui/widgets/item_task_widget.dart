import 'package:flutter/material.dart';
import 'package:flutter_codigo5_fire_task/models/task_model.dart';

import '../general/colors.dart';
import 'item_type_widget.dart';

class ItemTaskWidget extends StatelessWidget {
  TaskModel taskModel;
  Function onFinished;

  ItemTaskWidget({required this.taskModel, required this.onFinished});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.024),
            offset: const Offset(4, 5),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTypeWidget(
                type: taskModel.type,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                taskModel.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kFontPrimaryColor,
                  decoration: taskModel.finished
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              Text(
                taskModel.description,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  color: kFontPrimaryColor.withOpacity(0.7),
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                taskModel.date,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  color: kFontPrimaryColor.withOpacity(0.95),
                ),
              ),
            ],
          ),
          // Positioned(
          //   top: 0.0,
          //   right: -5.0,
          //   child: GestureDetector(
          //     onTap: (){
          //       print("holaaaaa");
          //     },
          //     child: Icon(Icons.more_vert),
          //   ),
          // ),
          Positioned(
            top: -10.0,
            right: -20.0,
            child: PopupMenuButton(
              onSelected: (int value) {
                if (value == 1) {
                } else if (value == 2) {
                  onFinished();
                }
              },
              elevation: 2,
              color: Colors.white,
              icon: Icon(
                Icons.more_vert,
                color: kFontPrimaryColor.withOpacity(0.8),
              ),
              iconSize: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "Editar",
                      style: TextStyle(
                        color: kFontPrimaryColor.withOpacity(0.8),
                        fontSize: 13.0,
                      ),
                    ),
                    value: 1,
                    onTap: () {
                      print("Editar");
                    },
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "Finalizar",
                      style: TextStyle(
                        color: !taskModel.finished
                            ? kFontPrimaryColor.withOpacity(0.8)
                            : kFontPrimaryColor.withOpacity(0.4),
                        fontSize: 13.0,
                      ),
                    ),
                    value: 2,
                    onTap: () {},
                    enabled: taskModel.finished ? false : true,
                  ),
                ];
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: taskModel.finished
                ? Icon(
                    Icons.check_circle,
                    color: Color(0xff02c39a),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
