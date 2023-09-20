import 'package:flutter/material.dart';
import 'package:taskapp/modules/task_drawer/task_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.deepPurple,
        width: MediaQuery.of(context).size.width *0.55 ,
        child: const TaskDrawer(),
      ),
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          Text('data'),
    ],
      ),
    );
  }
}
