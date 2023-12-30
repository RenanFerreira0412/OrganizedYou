import 'package:flutter/material.dart';
import 'package:organized_you/components/build_task_form.dart';
import 'package:organized_you/controllers/task_controller.dart';
import 'package:organized_you/models/task.dart';
import 'package:organized_you/theme/app_theme.dart';
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
  late bool light;

  @override
  void initState() {
    super.initState();
    light = widget.task.isFinished;
    task = TaskController();
  }

  cardHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Chip(
          backgroundColor: widget.chipColor,
          side: BorderSide(width: 0, color: widget.chipColor!),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          label: Text(
            widget.task.category,
            style: AppTheme.typo.medium(12, Colors.black, 1.5, 1.5),
          ),
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
          style: AppTheme.typo.bold(20, Colors.black, 1.5, 1.5),
          textAlign: TextAlign.start,
        ),
        Utils.addVerticalSpace(10),
        Text(
          widget.task.description,
          style: AppTheme.typo.regular(15, Colors.black, 1.5, 1.5),
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
        style: AppTheme.typo.medium(13, Colors.black54, 1.5, 1.5),
        textAlign: TextAlign.start,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
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
                Utils.schowSnackBar('Tarefa deletada com sucesso!');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
