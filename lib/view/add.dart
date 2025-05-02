import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uts_app/controller/task_controller.dart';
import 'package:uts_app/model/task.dart';
import 'package:uts_app/view/home.dart';

class AddFormPage extends StatefulWidget {
  final Task? task;
  const AddFormPage({super.key, this.task});

  @override
  _AddFormPageState createState() => _AddFormPageState();
}

class _AddFormPageState extends State<AddFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      // Jika ada tugas, isi form dengan data tugas
      _subjectController.text = widget.task!.subject;
      _subtitleController.text = widget.task!.subtitle;
      _descriptionController.text = widget.task!.desc;
      _selectedDate = widget.task!.deadline;
      _selectedTime = TimeOfDay.fromDateTime(widget.task!.deadline);
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  DateTime combineDateTimeAndTimeOfDay(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tugas lagikah?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Matakuliah',
                  hintText: 'misalnya: TKPM',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Isi matakuliah';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _subtitleController,
                decoration: const InputDecoration(
                  labelText: 'Sorotan',
                  hintText: 'misalnya: Tugas 1',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Isi sorotan';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  hintText:
                      'misalnya: Segera dikerjakan, karena deadline segera datang',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Isi deskripsi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Belum diatur'
                          : DateFormat(
                            'dd MMM yyyy',
                            'en_US',
                          ).format(_selectedDate!),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: const Text('Atur Tanggal'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedTime == null
                          ? 'Belum diatur'
                          : '${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickTime,
                    child: const Text('Atur Waktu'),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    DateTime combinedDateTime = combineDateTimeAndTimeOfDay(
                      _selectedDate!,
                      _selectedTime!,
                    );

                    final task = Task(
                      id:
                          widget.task?.id ??
                          '', // Gunakan ID lama jika mengedit
                      subject: _subjectController.text,
                      subtitle: _subtitleController.text,
                      desc: _descriptionController.text,
                      deadline: combinedDateTime,
                    );

                    if (widget.task == null) {
                      await TaskController().addTask(task);
                    } else {
                      await TaskController().updateTask(task.id, task);
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.task == null
                              ? 'Tugas berhasil disimpan'
                              : 'Perubahan berhasil disimpan',
                        ),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.save, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      widget.task == null ? 'Tambah' : 'Simpan',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
