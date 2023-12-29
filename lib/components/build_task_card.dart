import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:organized_you/controllers/task_controller.dart';
import 'package:organized_you/models/task.dart';
import 'package:organized_you/responsive/responsive.dart';
import 'package:organized_you/services/auth_service.dart';
import 'package:organized_you/utils/utils.dart';
import 'package:organized_you/widgets/cards.dart';

class BuildTaskCard extends StatefulWidget {
  final String? category;
  final bool? isFinished;

  const BuildTaskCard({super.key, this.category, this.isFinished});

  @override
  State<BuildTaskCard> createState() => _BuildTaskCardState();
}

class _BuildTaskCardState extends State<BuildTaskCard> {
  late AuthService auth;
  late TaskController controller;
  late Stream<QuerySnapshot> taskStream;

  @override
  void initState() {
    auth = AuthService();
    controller = TaskController();
    getTasks();
    super.initState();
  }

  getTasks() {
    if (widget.category != null) {
      taskStream = controller.tasks
          .where('uid', isEqualTo: auth.userId())
          .where('category', isEqualTo: widget.category)
          .snapshots();
    } else {
      debugPrint(widget.isFinished.toString());
      taskStream = controller.tasks
          .where('uid', isEqualTo: auth.userId())
          .where('is_finished', isEqualTo: widget.isFinished)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: taskStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.count(
          crossAxisCount: Responsive.isDesktop(context)
              ? 3
              : Responsive.isTablet(context)
                  ? 2
                  : 1,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            Task task = Task(
                id: document.id,
                isFinished: false,
                uid: auth.userId(),
                title: data['title'],
                description: data['description'],
                date: data['date'],
                category: data['category']);

            Color? chipColor = Utils.chipColor(task.category);

            return TaskCard(task: task, chipColor: chipColor);
          }).toList(),
        );
      },
    );
  }
}
