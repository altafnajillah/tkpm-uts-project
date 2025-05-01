import 'package:flutter/material.dart';
import 'package:uts_app/view/add.dart';
import 'package:uts_app/view/detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Daftar Tugasta"),
      ),
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            for (int index = 1; index < 21; index++)
              ListTile(
                leading: ExcludeSemantics(
                  // child: CircleAvatar(child: Text('$index')),
                  child: CircleAvatar(child: Icon(Icons.task_alt)),
                ),
                title: Text("Item $index"),
                subtitle: const Text(
                  "Tugas 1 - Membuat Aplikasi CRUD Hello hello world",
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailPage()),
                  );
                },
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Text("24 Januari"), Text("20.00")],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFormPage()),
          );
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
