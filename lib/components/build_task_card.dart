import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:organized_you/controllers/task_controller.dart';
import 'package:organized_you/models/card_color.dart';
import 'package:organized_you/models/task.dart';
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
      if (widget.isFinished != null) {
        taskStream = controller.tasks
            .where('uid', isEqualTo: auth.userId())
            .where('is_finished', isEqualTo: true)
            .snapshots();
      } else {
        taskStream =
            controller.tasks.where('uid', isEqualTo: auth.userId()).snapshots();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: taskStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (width > 1300)
                ? 3
                : (width > 1000 && width < 1300)
                    ? 2
                    : 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
            childAspectRatio: (width > 1300)
                ? 1.5
                : (width > 1200 && width < 1300)
                    ? 2
                    : (width > 1000 && width < 1200)
                        ? 1.5
                        : (width > 820 && width < 1000)
                            ? 2.4
                            : (width >= 790 && width < 820)
                                ? 2.1
                                : (width >= 650 && width < 790)
                                    ? 2.4
                                    : (width >= 540 && width < 650)
                                        ? 2
                                        : (width >= 460 && width < 540)
                                            ? 1.8
                                            : (width >= 390 && width < 460)
                                                ? 1.5
                                                : 1.3,
          ),
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            Task task = Task(
                id: document.id,
                isFinished: data['is_finished'],
                uid: auth.userId(),
                title: data['title'],
                description: data['description'],
                date: data['date'],
                category: data['category']);

            CardColor? cardColor = Utils.cardColor(task.category);

            return TaskCard(task: task, cardColor: cardColor);
          },
          itemCount: snapshot.data!.docs.length,
        );
      },
    );
  }
}
