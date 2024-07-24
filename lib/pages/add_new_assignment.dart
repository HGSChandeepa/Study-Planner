import 'package:flutter/material.dart';
import 'package:madman/widgets/sample_button.dart';
import 'package:madman/widgets/sample_input.dart';

class AddAssignmentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _assignmentNameController =
      TextEditingController();
  final TextEditingController _assignmentDescriptionController =
      TextEditingController();
  final TextEditingController _assignmentDurationController =
      TextEditingController();
  final ValueNotifier<DateTime> _selectedDate =
      ValueNotifier<DateTime>(DateTime.now());
  final ValueNotifier<TimeOfDay> _selectedTime =
      ValueNotifier<TimeOfDay>(TimeOfDay.now());

  AddAssignmentScreen({super.key}) {
    // Initialize ValueNotifiers with current date and time
    _selectedDate.value = DateTime.now();
    _selectedTime.value = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate.value) {
      _selectedDate.value = picked;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime.value,
    );

    if (picked != null && picked != _selectedTime.value) {
      _selectedTime.value = picked;
    }
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      // Add assignment to Firestore or any other storage here

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Assignment added successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Add New Assignment',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),

                //description
                const Text(
                  'Fill in the details below to add a new assignment. And start managing your study planner.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                CourseInputField(
                  controller: _assignmentNameController,
                  labelText: 'Assignment Name',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the assignment name';
                    }
                    return null;
                  },
                ),
                CourseInputField(
                  controller: _assignmentDescriptionController,
                  labelText: 'Assignment Description',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the assignment description';
                    }
                    return null;
                  },
                ),
                CourseInputField(
                  controller: _assignmentDurationController,
                  labelText: 'Duration (e.g., 1 hour)',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the assignment duration';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Divider(),
                const Text(
                  'Due Date and Time',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),

                ValueListenableBuilder<DateTime>(
                  valueListenable: _selectedDate,
                  builder: (context, date, child) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Date: ${date.toLocal().toString().split(' ')[0]}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                      ],
                    );
                  },
                ),
                ValueListenableBuilder<TimeOfDay>(
                  valueListenable: _selectedTime,
                  builder: (context, time, child) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Time: ${time.format(context)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () => _selectTime(context),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Add Assignment',
                  onPressed: () => _submitForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
