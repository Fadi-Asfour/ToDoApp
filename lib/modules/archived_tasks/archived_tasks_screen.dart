import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/providers/home_layout_provider.dart';
import 'package:todoappp/shared/components.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);
// Consumer(
//           builder: (BuildContext context, value, Widget? child) {  },
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeLayoutProvider>(
        builder: (context, value, Widget? child) =>
            Provider.of<HomeLayoutProvider>(context).archivedTasks.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu),
                        Text('No archived tasks, so please add someone !!!')
                      ],
                    ),
                  )
                : ListView.separated(
                    itemBuilder: ((context, index) =>
                        buildTaskItem(value.archivedTasks[index], context)),
                    separatorBuilder: (context, index) => Container(
                          width: double.infinity,
                        ),
                    itemCount: Provider.of<HomeLayoutProvider>(context)
                        .archivedTasks
                        .length));
  }
}
