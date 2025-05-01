import 'package:flutter/material.dart';

class AddFormPage extends StatefulWidget {
  const AddFormPage({super.key});

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      print('Matakulaih: ${_subjectController.text}');
      print('Sorotan: ${_subtitleController.text}');
      print('Deskripsi: ${_descriptionController.text}');
      print('Tanggal: ${_selectedDate?.toLocal().toString().split(' ')[0]}');
      print('Jam: ${_selectedTime?.format(context)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tugas lagikah?')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
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
              SizedBox(height: 24),
              TextFormField(
                controller: _subtitleController,
                decoration: InputDecoration(
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
              SizedBox(height: 24),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
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
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Belum diatur'
                          : 'Tanggal: ${_selectedDate?.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: Text('Atur Tanggal'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedTime == null
                          ? 'Belum diatur'
                          : 'Waktu: ${_selectedTime?.format(context)}',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickTime,
                    child: Text('Atur Waktu'),
                  ),
                ],
              ),
              SizedBox(height: 32),
              ElevatedButton(onPressed: _submitForm, child: Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}
