import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/providers/home_layout_provider.dart';
import 'package:uuid/uuid.dart';

int cn = 0;
Widget buildTaskItem(Map model, context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(model['time']),
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model['title'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
                Text(
                  model['date'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          IconButton(
              onPressed: () {
                Provider.of<HomeLayoutProvider>(context, listen: false)
                    .updateData(status: 'done', id: model['id']);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.tealAccent,
              )),
          IconButton(
              onPressed: () {
                Provider.of<HomeLayoutProvider>(context, listen: false)
                    .updateData(status: 'archived', id: model['id']);
              },
              icon: Icon(Icons.archive)),
          IconButton(
              onPressed: () {
                Provider.of<HomeLayoutProvider>(context, listen: false)
                    .deleteData(id: model['id']);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      ),
    );
