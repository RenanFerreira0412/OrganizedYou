import 'package:flutter/material.dart';
import 'package:organized_you/components/editor.dart';
import 'package:organized_you/controllers/task_controller.dart';
import 'package:organized_you/models/task.dart';
import 'package:organized_you/services/auth_service.dart';
import 'package:organized_you/theme/app_theme.dart';
import 'package:organized_you/utils/utils.dart';
import 'package:organized_you/validation/validation.dart';

class BuildTaskForm extends StatefulWidget {
  final bool isEditing;
  final Task? task;

  const BuildTaskForm({super.key, required this.isEditing, this.task});

  @override
  State<BuildTaskForm> createState() => _BuildTaskFormState();
}

class _BuildTaskFormState extends State<BuildTaskForm> {
  final formKey = GlobalKey<FormState>();

  // Controladores
  final title = TextEditingController();
  final description = TextEditingController();
  final date = TextEditingController();

  // Categorias das tarfeas
  List<String> categories = Utils.categories;

  String? category;

  late AuthService auth;
  late TaskController task;

  @override
  void initState() {
    super.initState();
    auth = AuthService();
    task = TaskController();
    setFieldVals();
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    date.dispose();

    super.dispose();
  }

  setFieldVals() {
    if (widget.isEditing) {
      setState(() {
        title.text = widget.task!.title;
        description.text = widget.task!.description;
        date.text = widget.task!.date;
        category = widget.task!.category;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: widget.isEditing
          ? Text(
              'Editar Tarefa',
              style: AppTheme.typo.medium(20, Colors.black, 1.5, 1.5),
            )
          : Text(
              'Adicionar Tarefa',
              style: AppTheme.typo.medium(20, Colors.black, 1.5, 1.5),
            ),
      content: SizedBox(
        width: 500,
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Campo assunto (título)
                Editor(
                    controller: title,
                    labelText: 'Assunto',
                    hintText: 'Assunto da tarefa',
                    validator: FormValidation.validateField(),
                    maxLength: 60,
                    maxLines: 1,
                    isPasswordField: false,
                    readOnly: false,
                    keyboardType: TextInputType.text),

                // Campo categoria
                DropdownButtonFormField(
                    validator: FormValidation.validateField(),
                    decoration: InputDecoration(
                      labelText: 'Categoria',
                      hintText: 'Selecione a categoria',
                      helperText: 'Selecione a categoria',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    items: categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: category,
                    onChanged: (String? value) {
                      setState(() {
                        category = value!;
                      });
                    }),

                // Campo data
                Editor(
                    controller: date,
                    labelText: 'Data',
                    hintText: 'Data de entraga/finalização da tarefa',
                    validator: FormValidation.validateField(),
                    maxLength: 10,
                    maxLines: 1,
                    isPasswordField: false,
                    readOnly: true,
                    action: () => _selectDate(),
                    keyboardType: TextInputType.datetime),

                // Campo descrição
                Editor(
                    controller: description,
                    labelText: 'Descrição',
                    hintText: 'Descrição da tarefa',
                    validator: FormValidation.validateField(),
                    maxLength: 300,
                    maxLines: 4,
                    isPasswordField: false,
                    readOnly: false,
                    keyboardType: TextInputType.text),
              ],
            )),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Salvar'),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Task newTask = Task(
                  isFinished: false,
                  uid: auth.userId(),
                  title: title.text,
                  description: description.text,
                  date: date.text,
                  category: category!);

              if (widget.isEditing) {
                // Editando a tarefa
                task.updateTask(newTask, widget.task!.id);
                Utils.schowSnackBar('Tarefa editada com sucesso!');
              } else {
                // Adicionando a tarefa
                task.createTask(newTask);
                Utils.schowSnackBar('Tarefa cadastrada com sucesso!');
              }
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  _selectDate() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      helpText: 'Selecione uma data',
    );

    if (newDate != null) {
      setState(() {
        date.text = '${newDate.day}/${newDate.month}/${newDate.year}';
        debugPrint(date.text);
      });
    }
  }
}
