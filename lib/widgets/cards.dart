import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organized_you/components/build_task_form.dart';
import 'package:organized_you/controllers/task_controller.dart';
import 'package:organized_you/models/card_color.dart';
import 'package:organized_you/models/task.dart';
import 'package:organized_you/theme/app_theme.dart';
import 'package:organized_you/utils/utils.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final CardColor? cardColor;

  const TaskCard({super.key, required this.cardColor, required this.task});

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
          backgroundColor: widget.cardColor!.primary,
          shape: StadiumBorder(
              side: BorderSide(width: 1, color: widget.cardColor!.secondary)),
          label: Text(
            widget.task.category,
            style: AppTheme.typo.medium(12, Colors.black, 1.5, 1.5),
          ),
        ),
        Row(
          children: [
            CupertinoSwitch(
              value: light,
              activeColor: widget.cardColor!.secondary,
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: AppTheme.colors.dark.withOpacity(0.1),
          //     spreadRadius: 5,
          //     blurRadius: 7,
          //     offset: const Offset(0, 3), // changes position of shadow
          //   ),
          // ],
          color: widget.cardColor!.primary),
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
    );
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
          backgroundColor: AppTheme.colors.dark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Deletar Tarefa',
            style: AppTheme.typo.medium(20, AppTheme.colors.white, 1.5, 1.5),
          ),
          buttonPadding: const EdgeInsets.all(20),
          content: Text(
            'Esta ação irá deletar a sua tarefa.',
            style: AppTheme.typo.regular(15, Colors.white54, 1, 1.5),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.colors.dark,
                textStyle:
                    AppTheme.typo.medium(15, AppTheme.colors.dark, 1, 1.5),
                backgroundColor: AppTheme.colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.colors.dark,
                textStyle:
                    AppTheme.typo.medium(15, AppTheme.colors.dark, 1, 1.5),
                backgroundColor: AppTheme.colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
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
