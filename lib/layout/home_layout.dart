import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoappp/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todoappp/modules/done_tasks/done_tasks_screen.dart';
import 'package:todoappp/modules/new_tasks/new_tasks_screen.dart';
import 'package:todoappp/providers/home_layout_provider.dart';
import 'package:todoappp/shared/components.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _nameState();
}

class _nameState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];
  List<String> titles = ['Tasks', 'Done Tasks', 'Archived Tasks'];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future.delayed(Duration.zero, () {
  //     Provider.of<HomeLayoutProvider>(context).createDatabase();
  //   });
  // }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<HomeLayoutProvider>(context).createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Provider.of<HomeLayoutProvider>(context).ScaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: Provider.of<HomeLayoutProvider>(context).tasks.length == null
          ? Center(child: CircularProgressIndicator())
          : screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Provider.of<HomeLayoutProvider>(context, listen: false)
              .isBottomShown) {
            if (Provider.of<HomeLayoutProvider>(context, listen: false)
                .formKey
                .currentState!
                .validate()) {
              Navigator.pop(context);

              Provider.of<HomeLayoutProvider>(context, listen: false)
                  .insertToDatabase();

              // titleController.text = '';
              // timeController.text = '';

              Provider.of<HomeLayoutProvider>(context, listen: false)
                  .changeIsBottomShown(false);
            }
          } else {
            Provider.of<HomeLayoutProvider>(context, listen: false)
                .ScaffoldKey
                .currentState
                ?.showBottomSheet((context) => Container(
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: Provider.of<HomeLayoutProvider>(context).formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                                controller: Provider.of<HomeLayoutProvider>(
                                  context,
                                ).titleController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'title must not be empty';
                                  }
                                },
                                decoration: InputDecoration(
                                    // errorText: 'fffffffffffffffff',
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 5.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.greenAccent,
                                          width: 5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.teal, width: 5.0),
                                    ),
                                    hintText: 'Enter title',
                                    labelText: 'Task Title',
                                    //   hintTextDirection: TextDirection.ltr,
                                    prefixIcon: Icon(Icons.task))
                                //showCursor: false,
                                ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    // print( "TIIIIIIIIIIIIME: ${value.toString()}");

                                    Provider.of<HomeLayoutProvider>(context,
                                            listen: false)
                                        .changeTimeController(
                                            value!.format(context).toString());
                                  });
                                },
                                controller: Provider.of<HomeLayoutProvider>(
                                  context,
                                ).timeController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'time must not be empty';
                                  }
                                },
                                decoration: InputDecoration(
                                    // errorText: 'fffffffffffffffff',
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 5.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.greenAccent,
                                          width: 5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.teal, width: 5.0),
                                    ),
                                    hintText: 'Enter time',
                                    labelText: 'Task Time',
                                    //  hintTextDirection: TextDirection.ltr,
                                    prefixIcon:
                                        Icon(Icons.watch_later_outlined))
                                //showCursor: false,
                                ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                onTap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse('2022-06-01'))
                                      .then((valuee) {
                                    // print( "DAAAAAAAAAte: ${DateFormat.yMMMd().format(value!)}");
                                    Provider.of<HomeLayoutProvider>(context,
                                            listen: false)
                                        .changeDateController(
                                            DateFormat.yMMMd().format(valuee!));
                                    // timeController.text =
                                    //     value!.format(context).toString();
                                  });
                                },
                                controller: Provider.of<HomeLayoutProvider>(
                                  context,
                                ).dateController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'date must not be empty';
                                  }
                                },
                                decoration: InputDecoration(
                                    // errorText: 'fffffffffffffffff',
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 5.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.greenAccent,
                                          width: 5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.teal, width: 5.0),
                                    ),
                                    hintText: 'Enter Date',
                                    labelText: 'Task Date',
                                    //  hintTextDirection: TextDirection.ltr,
                                    prefixIcon:
                                        Icon(Icons.watch_later_outlined))
                                //showCursor: false,
                                ),
                          ],
                        ),
                      ),
                    ))
                .closed
                .then((value) {
              //Navigator.pop(context);

              // titleController.text = '';
              // timeController.text = '';
              Provider.of<HomeLayoutProvider>(context, listen: false)
                  .changeIsBottomShown(false);
            });
            Provider.of<HomeLayoutProvider>(context, listen: false)
                .changeIsBottomShown(true);
          }
        },
        child: Icon(Provider.of<HomeLayoutProvider>(context).isBottomShown
            ? Icons.add
            : Icons.edit),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.teal,
          //  selectedItemColor: Colors.tealAccent,
          unselectedItemColor: Colors.teal[900],
          fixedColor: Colors.green,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.menu), label: 'Tasks'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline_outlined), label: 'Done'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: 'Archived'),
          ]),
      // body: ,
      //This code from Abdallah Mansour course
    );
  }
}
