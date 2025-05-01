import 'package:flutter/material.dart';

class AddFormPage extends StatefulWidget {
  const AddFormPage({super.key});

  @override
  _AddFormPageState createState() => _AddFormPageState();
}

class _AddFormPageState extends State<AddFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
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
      print('Title: ${_titleController.text}');
      print('Subtitle: ${_subtitleController.text}');
      print('Description: ${_descriptionController.text}');
      print('Date: ${_selectedDate?.toLocal().toString().split(' ')[0]}');
      print('Time: ${_selectedTime?.format(context)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _subtitleController,
                decoration: InputDecoration(labelText: 'Subtitle'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subtitle';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
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
                          ? 'No date selected'
                          : 'Date: ${_selectedDate?.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: Text('Pick Date'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedTime == null
                          ? 'No time selected'
                          : 'Time: ${_selectedTime?.format(context)}',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickTime,
                    child: Text('Pick Time'),
                  ),
                ],
              ),
              SizedBox(height: 32),
              ElevatedButton(onPressed: _submitForm, child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
