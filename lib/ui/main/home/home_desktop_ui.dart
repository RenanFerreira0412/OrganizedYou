import 'package:flutter/material.dart';
import 'package:organized_you/components/all_tasks.dart';
import 'package:organized_you/components/build_task_card.dart';
import 'package:organized_you/components/build_task_form.dart';
import 'package:organized_you/services/auth_service.dart';
import 'package:organized_you/theme/app_theme.dart';
import 'package:provider/provider.dart';

class HomeDesktopUI extends StatefulWidget {
  const HomeDesktopUI({super.key});

  @override
  State<HomeDesktopUI> createState() => _HomeDesktopUIState();
}

class _HomeDesktopUIState extends State<HomeDesktopUI> {
  late int selectedIndex;
  Widget? page;

  @override
  void initState() {
    setPage(0);
    super.initState();
  }

  setPage(index) {
    setState(() {
      selectedIndex = index;
    });

    switch (selectedIndex) {
      case 0:
        page = AllTasks(
          key: Key(selectedIndex.toString()),
        );
        break;
      case 1:
        page = BuildTaskCard(
            key: Key(selectedIndex.toString()), category: 'Pessoal');
        break;
      case 2:
        page = BuildTaskCard(
            key: Key(selectedIndex.toString()), category: 'Acadêmico');
        break;
      case 3:
        page = BuildTaskCard(
            key: Key(selectedIndex.toString()), category: 'Trabalho');
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Suas Tarefas'),
          actions: [
            IconButton(
              onPressed: () => auth.logout(),
              icon: const Icon(Icons.logout_rounded),
            ),
          ],
        ),
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                backgroundColor: AppTheme.colors.dark,
                indicatorColor: Colors.grey.shade800,
                selectedIconTheme: IconThemeData(color: AppTheme.colors.white),
                unselectedIconTheme:
                    IconThemeData(color: AppTheme.colors.white),
                selectedLabelTextStyle:
                    AppTheme.typo.medium(15, AppTheme.colors.white, 1, 1.5),
                unselectedLabelTextStyle:
                    AppTheme.typo.medium(15, AppTheme.colors.white, 1, 1.5),
                useIndicator: true,
                extended: constraints.maxWidth >= 800,
                labelType: constraints.maxWidth >= 800
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    selectedIcon: Icon(Icons.home_rounded),
                    icon: Icon(Icons.home_outlined),
                    label: Text('Todas'),
                  ),
                  NavigationRailDestination(
                    selectedIcon: Icon(Icons.person_rounded),
                    icon: Icon(Icons.person_outline_rounded),
                    label: Text('Pessoal'),
                  ),
                  NavigationRailDestination(
                    selectedIcon: Icon(Icons.school_rounded),
                    icon: Icon(Icons.school_outlined),
                    label: Text('Acadêmico'),
                  ),
                  NavigationRailDestination(
                    selectedIcon: Icon(Icons.work_rounded),
                    icon: Icon(Icons.work_outline_rounded),
                    label: Text('Trabalho'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                    setPage(value);
                  });
                },
              ),
            ),
            VerticalDivider(
              thickness: 1,
              width: 1,
              color: Colors.grey.shade800,
            ),
            Expanded(
              child: Container(
                color: AppTheme.colors.dark,
                child: page,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _openTaskForm(context),
          tooltip: 'Criar Tarefa',
          label: const Text('Criar Tarefa'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.grey.shade800,
        ),
      );
    });
  }

  Future<void> _openTaskForm(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const BuildTaskForm(isEditing: false);
      },
    );
  }
}
