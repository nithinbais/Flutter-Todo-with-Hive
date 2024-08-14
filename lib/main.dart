import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todohive/data/hive_data_store.dart';
import 'package:todohive/models/task_model.dart';
import 'package:todohive/screens/home_screen.dart';

void main() async {
  // Init DB before runApp
  await Hive.initFlutter();

  // Register Hive adapter
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());

  // Open a box
  final box = await Hive.openBox<TaskModel>(HiveDataStore.boxName);

  // Delete outdated tasks
  box.values.forEach((task) {
    if (task.createdAtDate.day != DateTime.now().day) {
      task.delete();
    }
  });

  runApp(BaseWidget(child: const MyApp()));
}

// InheritedWidget for providing HiveDataStore
class BaseWidget extends InheritedWidget {
  BaseWidget({Key? key, required this.child}) : super(key: key, child: child);

  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('Could not find ancestor widget of type BaseWidget');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.black, fontSize: 14),
          displayMedium: TextStyle(color: Colors.white, fontSize: 21),
          displaySmall: TextStyle(color: Colors.white10),
          titleLarge: TextStyle(
              color: Colors.black, fontSize: 40, fontWeight: FontWeight.w300),
          titleMedium: TextStyle(
              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300),
          titleSmall:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          headlineMedium: TextStyle(color: Colors.grey, fontSize: 17),
          headlineSmall: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
