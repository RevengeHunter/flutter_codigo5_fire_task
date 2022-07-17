import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../general/colors.dart';

class TextfieldWidget extends StatelessWidget {

  String hintText;
  IconData icon;
  int? maxLines;
  bool isDatePicker;
  Function? onTap;
  TextEditingController textEditingController;

  TextfieldWidget({required this.hintText, required this.icon, this.maxLines, this.isDatePicker = false, this.onTap, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: textEditingController,
        style: TextStyle(
          color: kFontPrimaryColor,
          height: 1.0,
          fontSize: 13.0,
        ),
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor: kBrandPrimaryColor,
          hintText: hintText,
          hintStyle: TextStyle(
            height: 1.0,
            fontSize: 13.0,
            color: kFontPrimaryColor.withOpacity(0.7),
          ),
          prefixIcon: Icon(
            icon,
            color: kFontPrimaryColor.withOpacity(0.55),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
        ),
        onTap: (){
          if(isDatePicker){
            FocusScope.of(context).requestFocus(FocusNode());
            onTap!();
          }
        },
        //Todo lo que se ingresa al campo es el value
        validator: (String? value){
          if(value!.isEmpty && value != null){
            return "El campo es obligatorio";
          }
          return null;
        },
      ),
    );
  }
}
