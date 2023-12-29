import 'package:flutter/material.dart';
import 'package:organized_you/components/build_task_form.dart';
import 'package:organized_you/controllers/task_controller.dart';
import 'package:organized_you/models/task.dart';
import 'package:organized_you/utils/utils.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final Color? chipColor;

  const TaskCard({super.key, required this.chipColor, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late TaskController task;
  bool light = false;

  @override
  void initState() {
    super.initState();
    task = TaskController();
  }

  cardHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Chip(
          backgroundColor: widget.chipColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          label: Text(widget.task.category),
        ),
        Row(
          children: [
            Switch(
              value: light,
              activeColor: widget.chipColor,
              onChanged: (bool value) {
                setState(() {
                  light = value;
                });
                // atualizando o status da tarefa (finalizada ou não)
                task.updateStatus(widget.task.id, value);
              },
            ),
            IconButton(
                onPressed: () => _openTaskForm(context),
                icon: const Icon(Icons.edit_rounded)),
            IconButton(
                onPressed: () => _deleteTask(context),
                icon: const Icon(Icons.delete_rounded))
          ],
        )
      ],
    );
  }

  cardBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.task.title,
          textAlign: TextAlign.start,
        ),
        Utils.addVerticalSpace(10),
        Text(
          widget.task.description,
          textAlign: TextAlign.start,
        )
      ],
    );
  }

  cardFooter() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Text(
        widget.task.date,
        textAlign: TextAlign.start,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardHeader(),
          Utils.addVerticalSpace(15),
          cardBody(),
          Utils.addVerticalSpace(30),
          cardFooter()
        ],
      ),
    ));
  }

  Future<void> _openTaskForm(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BuildTaskForm(
          isEditing: true,
          task: widget.task,
        );
      },
    );
  }

  Future<void> _deleteTask(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deletar Tarefa'),
          content: const Text(
            'Esta ação irá deletar a sua tarefa.',
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
              child: const Text('Deletar'),
              onPressed: () {
                task.deleteTask(widget.task.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
