import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayoutProvider with ChangeNotifier {
  Database? database;
  List<Map> tasks = [];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  bool isBottomShown = false;
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  Future<void> insertToDatabase() async {
    database?.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks (title,date,time,status) VALUES ("${titleController.text}","${dateController.text}","${timeController.text}","new")',
      )
          .then((value) {
        print('$value inserted successfully');
        getDataFromDatabase(database).then(
          (value) {
            tasks = value;
            tasks.forEach((element) {
              if (element['status'] == 'new')
                newTasks.add(element);
              else if (element['status'] == 'done')
                doneTasks.add(element);
              else
                archivedTasks.add(element);
            });
            print(value);
          },
        );
        titleController.clear();
        timeController.clear();
        dateController.clear();
        // tasks = database as List<Map>;
      }).catchError((error) {
        print('Error when inserting new record ${error.toString()}');
      });
    });
    notifyListeners();
  }

  void deleteData({required int id}) async {
    database!
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id])
        .then((value) => {
              print(
                  '/////////dssssssssssssssssssssssssssssssssssssssssss$value'),
              getDataFromDatabase(database).then(
                (value) {
                  tasks = value;
                  tasks.forEach((element) {
                    if (element['status'] == 'new')
                      newTasks.add(element);
                    else if (element['status'] == 'done')
                      doneTasks.add(element);
                    else
                      archivedTasks.add(element);
                  });
                  print(tasks);
                  print(newTasks);
                  print(doneTasks);
                  print(archivedTasks);
                },
              )
            })
        .catchError((error) {
          print('Error when deleting new record ${error.toString()}');
        });

    notifyListeners();
  }

  void updateData({
    required String status,
    required int id,
  }) {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', '$id'],
    ).then((value) {
      getDataFromDatabase(database).then(
        (value) {
          tasks = value;
          tasks.forEach((element) {
            if (element['status'] == 'new')
              newTasks.add(element);
            else if (element['status'] == 'done')
              doneTasks.add(element);
            else
              archivedTasks.add(element);
          });
          print(tasks);
          print(newTasks);
          print(doneTasks);
          print(archivedTasks);
        },
      );
    });
    notifyListeners();
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY ,title TEXT ,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error when Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database opened');
        getDataFromDatabase(database).then(
          (value) {
            tasks = value;
            tasks.forEach((element) {
              if (element['status'] == 'new')
                newTasks.add(element);
              else if (element['status'] == 'done')
                doneTasks.add(element);
              else
                archivedTasks.add(element);
            });
            print(tasks);
            print(newTasks);
            print(doneTasks);
            print(archivedTasks);
          },
        );
        //   print(tasks);
      },
    );
    notifyListeners();
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    return await database!.rawQuery('SELECT * FROM tasks');
    // print(tasks);
  }

  void changeIsBottomShown(bool b) {
    isBottomShown = b;
    notifyListeners();
  }

  void changeTimeController(String time) {
    timeController.text = time;
    notifyListeners();
  }

  void changeDateController(String date) {
    dateController.text = date;
    notifyListeners();
  }
}
