import 'package:flutter/material.dart';
import 'package:organized_you/components/all_tasks.dart';
import 'package:organized_you/components/build_task_card.dart';
import 'package:organized_you/components/build_task_form.dart';
import 'package:organized_you/services/auth_service.dart';
import 'package:organized_you/theme/app_theme.dart';
import 'package:provider/provider.dart';

class HomeMobileUI extends StatefulWidget {
  const HomeMobileUI({super.key});

  @override
  State<HomeMobileUI> createState() => _HomeMobileUIState();
}

class _HomeMobileUIState extends State<HomeMobileUI>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suas Tarefas'),
        actions: [
          IconButton(
            onPressed: () => auth.logout(),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        children: const [
          AllTasks(), // Todas as tarefas
          BuildTaskCard(category: 'Pessoal'), // Tarefas pessoais
          BuildTaskCard(category: 'Acadêmico'), // Tarefas acadêmicas
          BuildTaskCard(category: 'Trabalho'), // Tarefas profissionais
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTaskForm(context),
        tooltip: 'Adicionar Tarefa',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        },
        indicatorColor: AppTheme.colors.yellow,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_rounded),
            icon: Icon(Icons.home_outlined),
            label: 'Todas',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_rounded),
            icon: Icon(Icons.person_outline_rounded),
            label: 'Pessoal',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school_rounded),
            icon: Icon(Icons.school_outlined),
            label: 'Acadêmico',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.work_rounded),
            icon: Icon(Icons.work_outline_rounded),
            label: 'Trabalho',
          ),
        ],
      ),
    );
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
