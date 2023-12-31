import 'package:flutter/cupertino.dart';

import 'package:organized_you/components/build_task_card.dart';
import 'package:organized_you/theme/app_theme.dart';
import 'package:organized_you/utils/utils.dart';

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
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 20),
          child: Row(
            children: [
              CupertinoSwitch(
                value: isFinished,
                activeColor: AppTheme.colors.offWhite,
                onChanged: (bool value) {
                  setState(() {
                    isFinished = value;
                    onSwitchValueChanged(value);
                  });
                },
              ),
              Utils.addHorizontalSpace(5),
              Text(
                'Mostrar apenas as tarefas finalizadas.',
                style: AppTheme.typo.regular(14, AppTheme.colors.white, 1, 1.5),
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
        Expanded(child: tasks)
      ],
    );
  }
}
