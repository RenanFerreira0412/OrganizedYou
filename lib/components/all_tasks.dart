import 'package:flutter/material.dart';
import 'package:organized_you/components/build_task_card.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({super.key});

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  late bool isFinished;
  late Widget tasks;

  @override
  void initState() {
    super.initState();
    onSwitchValueChanged(false);
  }

  onSwitchValueChanged(bool action) {
    setState(() {
      isFinished = action;
      tasks = _buildTasksWidget();
    });
  }

  Widget _buildTasksWidget() {
    if (isFinished) {
      return BuildTaskCard(
        key: Key(isFinished.toString()),
        isFinished: isFinished,
      );
    } else {
      return const BuildTaskCard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Switch(
              value: isFinished,
              activeColor: Colors.blue,
              onChanged: (bool value) {
                setState(() {
                  isFinished = value;
                  onSwitchValueChanged(value);
                });
              },
            ),
            const Text(
              'Mostrar apenas as tarefas finalizadas.',
              textAlign: TextAlign.start,
            )
          ],
        ),
        Expanded(child: tasks)
      ],
    );
  }
}
