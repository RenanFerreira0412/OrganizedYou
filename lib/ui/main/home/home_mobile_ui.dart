import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
        elevation: 0,
        title: const Text(
          'Suas Tarefas',
        ),
        actions: [
          IconButton(
            onPressed: () => auth.logout(),
            icon: const Icon(
              Icons.logout_rounded,
            ),
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey.shade800,
        onPressed: () => _openTaskForm(context),
        tooltip: 'Criar Tarefa',
        label: const Text('Criar Tarefa'),
        icon: const Icon(Icons.add),
      ),
      bottomNavigationBar: Container(
        color: AppTheme.colors.dark,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: AppTheme.colors.dark,
            onTabChange: (int index) {
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
            tabBackgroundColor: Colors.grey.shade800,
            activeColor: AppTheme.colors.white,
            color: AppTheme.colors.white,
            gap: 8,
            selectedIndex: currentPageIndex,
            padding: const EdgeInsets.all(16),
            //elevation: 5,
            tabs: const <GButton>[
              GButton(
                //selectedIcon: Icon(Icons.home_rounded),
                icon: Icons.home_outlined,

                text: 'Todas',
              ),
              GButton(
                //selectedIcon: Icon(Icons.person_rounded),
                icon: Icons.person_outline_rounded,
                text: 'Pessoal',
              ),
              GButton(
                //selectedIcon: Icon(Icons.school_rounded),
                icon: Icons.school_outlined,
                text: 'Acadêmico',
              ),
              GButton(
                //selectedIcon: Icon(Icons.work_rounded),
                icon: Icons.work_outline_rounded,
                text: 'Trabalho',
              ),
            ],
          ),
        ),
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
