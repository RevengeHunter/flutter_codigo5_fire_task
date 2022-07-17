import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_fire_task/models/task_model.dart';
import 'package:flutter_codigo5_fire_task/ui/widgets/textfield_widget.dart';
import '../general/colors.dart';
import 'package:intl/intl.dart';

class FormTaskWidget extends StatefulWidget {
  const FormTaskWidget({Key? key}) : super(key: key);

  @override
  State<FormTaskWidget> createState() => _FormTaskWidgetState();
}

class _FormTaskWidgetState extends State<FormTaskWidget> {
  String selectedType = "Personal";

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CollectionReference _taskCollection =
  FirebaseFirestore.instance.collection('tasks');

  late TaskModel newTaskModel;

  //Para que gestione los estados del formulario
  final formKey = GlobalKey<FormState>();

  showSelectDate() async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime(2022),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      helpText: "Selecciona fecha",
      locale: const Locale('es'),
      builder: (BuildContext context, Widget? widget) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Colors.white,
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide.none,
              ),
              elevation: 0,
            ),
            // buttonTheme: ButtonThemeData(
            //   textTheme: ButtonTextTheme.primary
            // ),
            colorScheme: ColorScheme.light(
              primary: kFontPrimaryColor,
            ),
          ),
          child: widget!,
        );
      },
    );

    if (dateTime != null) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String formatted = formatter.format(dateTime);
      _dateController.text = formatted;
    }
  }

  String key = "";

  addTask() {

    if (formKey.currentState!.validate()) {
      newTaskModel = TaskModel(
          title: _titleController.text,
          description: _descriptionController.text,
          date: _dateController.text,
          finished: false,
          type: selectedType);

      print(newTaskModel.toJson());

      _taskCollection
          .add({
        newTaskModel.toJson()
      },).then((value) {})
          .whenComplete(() {
        Navigator.pop(context);
      },).catchError((error){
        print(error);
      },);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.0),
          topRight: Radius.circular(14.0),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Agregar nueva tarea"),
              TextfieldWidget(
                hintText: "Título",
                icon: Icons.text_fields,
                textEditingController: _titleController,
              ),
              TextfieldWidget(
                hintText: "Descripción",
                icon: Icons.description,
                maxLines: 4,
                textEditingController: _descriptionController,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text("Tipo:"),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 10.0,
                children: [
                  FilterChip(
                    selected: selectedType == "Personal",
                    backgroundColor: kBrandPrimaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    selectedColor: typeColorMap[selectedType],
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: selectedType == "Personal"
                          ? Colors.white
                          : kFontPrimaryColor.withOpacity(0.7),
                    ),
                    label: Text("Personal"),
                    onSelected: (bool value) {
                      selectedType = "Personal";
                      setState(() {});
                    },
                  ),
                  FilterChip(
                    selected: selectedType == "Work",
                    backgroundColor: kBrandPrimaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    selectedColor: typeColorMap[selectedType],
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: selectedType == "Work"
                          ? Colors.white
                          : kFontPrimaryColor.withOpacity(0.7),
                    ),
                    label: Text(
                      "Work",
                    ),
                    onSelected: (bool value) {
                      selectedType = "Work";
                      setState(() {});
                    },
                  ),
                  FilterChip(
                    selected: selectedType == "School Task",
                    backgroundColor: kBrandPrimaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    selectedColor: typeColorMap[selectedType],
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: selectedType == "School Task"
                          ? Colors.white
                          : kFontPrimaryColor.withOpacity(0.7),
                    ),
                    label: Text(
                      "School Task",
                    ),
                    onSelected: (bool value) {
                      selectedType = "School Task";
                      setState(() {});
                    },
                  ),
                ],
              ),
              TextfieldWidget(
                hintText: "Fecha",
                icon: Icons.date_range,
                isDatePicker: true,
                onTap: () {
                  showSelectDate();
                },
                textEditingController: _dateController,
              ),
              const SizedBox(
                height: 12.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 52.0,
                child: ElevatedButton.icon(
                  onPressed: () {
                    addTask();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    primary: kFontPrimaryColor,
                  ),
                  icon: const Icon(
                    Icons.save,
                  ),
                  label: const Text(
                    "Agregar tarea",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}