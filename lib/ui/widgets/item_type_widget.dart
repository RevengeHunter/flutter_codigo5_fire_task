import 'package:flutter/material.dart';
import 'package:flutter_codigo5_fire_task/ui/general/colors.dart';

class ItemTypeWidget extends StatelessWidget {
  String type;
  ItemTypeWidget({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: typeColorMap[type],
      ),
      child: Text(
        type,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
