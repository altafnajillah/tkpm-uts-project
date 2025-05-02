import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uts_app/controller/task_controller.dart';
import 'package:uts_app/view/add.dart';
import 'package:uts_app/view/detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Daftar Tugasta",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Expanded(
        child: StreamBuilder(
          stream: TaskController().getTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Gagal memuat tugas'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada tugas'));
            }
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  leading: ExcludeSemantics(
                    child: CircleAvatar(child: Icon(Icons.task_alt)),
                  ),
                  title: Text(
                    task.subject,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(task.subtitle),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(taskId: task.id),
                      ),
                    );
                  },
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat(
                          'dd MMMM yyyy',
                          'en_US',
                        ).format(task.deadline),
                      ),
                      Text(DateFormat('HH:mm', 'en_US').format(task.deadline)),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFormPage()),
          );
        },
        tooltip: 'Tambah Tugas',
        child: const Icon(Icons.add),
      ),
    );
  }
}
