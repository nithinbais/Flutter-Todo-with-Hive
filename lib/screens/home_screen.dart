import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:todohive/main.dart';
import 'package:todohive/models/task_model.dart';
import 'package:todohive/screens/task_screen.dart';
import 'package:todohive/utils/colors.dart';
import 'package:todohive/widget/appbar.dart';
import 'package:todohive/widget/custom_drawer.dart';
import 'package:todohive/widget/space_exs.dart';
import 'package:todohive/widget/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  String lottieUrl = 'assets/lottie/lottietodo.json';

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenable(),
        builder: (context, Box<TaskModel> box, Widget? child) {
          var tasks = box.values.toList();
          // for sorting list
          tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtTime));
          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskScreen(
                      titleController: TextEditingController(),
                      descriptionController: TextEditingController(),
                      taskModel: TaskModel.create(
                        title: null,
                        subTitle: null,
                        createdAtTime: '',
                        createdAtDate: '',
                      ),
                    ),
                  ),
                );
              },
              backgroundColor: Colors.amber,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
            body: SafeArea(
              //drawer
              child: SliderDrawer(
                key: drawerKey,
                isDraggable: false,
                animationDuration: 1000,
                slider: CustomDrawer(),
                appBar: CustomAppbar(
                  drawerKey: drawerKey,
                ),
                //main body
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                value: 1 / 3,
                                backgroundColor: Colors.green,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                            const SizedBox(width: 25),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'My Task',
                                  style: TextStyle(fontSize: 30),
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  '1 of 3 tasks',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Divider(
                          thickness: 2,
                          indent: 100,
                          endIndent: 100,
                        ),
                      ),
                      Expanded(
                        child: tasks.isNotEmpty
                            ? ListView.builder(
                                itemCount: tasks.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  var task = tasks[index];
                                  return Dismissible(
                                    key: Key(task.id),
                                    direction: DismissDirection.horizontal,
                                    onDismissed: (_) {
                                      base.dataStore
                                          .deleteTask(task_model: task);
                                    },
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.delete_outline,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Delete',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: TaskWidget(taskModel: task),
                                  );
                                })
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: Lottie.asset(lottieUrl,
                                        animate:
                                            tasks.isNotEmpty ? false : true),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "No tasks available",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
