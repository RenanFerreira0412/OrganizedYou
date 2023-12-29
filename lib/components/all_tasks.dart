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
    onSwitchValueChanged(true);
  }

  onSwitchValueChanged(bool action) {
    setState(() {
      isFinished = action;
      tasks = _buildTasksWidget(); // Call a function to build the tasks widget
    });
  }

  Widget _buildTasksWidget() {
    if (isFinished) {
      return const Expanded(
        child: BuildTaskCard(
          isFinished: true,
        ),
      );
    } else {
      return const Expanded(
        child: BuildTaskCard(
          isFinished: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(isFinished.toString()),
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
        tasks
      ],
    );
  }
}
