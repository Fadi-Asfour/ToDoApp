import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/providers/home_layout_provider.dart';
import 'package:todoappp/shared/components.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);
// Consumer(
//           builder: (BuildContext context, value, Widget? child) {  },
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeLayoutProvider>(
        builder: (context, value, Widget? child) =>
            Provider.of<HomeLayoutProvider>(context).doneTasks.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu),
                        Text('No done tasks, so please add someone !!!')
                      ],
                    ),
                  )
                : ListView.separated(
                    itemBuilder: ((context, index) =>
                        buildTaskItem(value.doneTasks[index], context)),
                    separatorBuilder: (context, index) => Container(
                          width: double.infinity,
                        ),
                    itemCount: Provider.of<HomeLayoutProvider>(context)
                        .doneTasks
                        .length));
  }
}
