import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:database_management/database_Manager.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() {
    return _FormScreen();
  }
}

class _FormScreen extends State<FormScreen> {
  List<Student> _students = [];
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _sectionController = TextEditingController();

  @override
  void initState() {
    _loadStudent();
    super.initState();
  }

  _loadStudent() async {
    List<Student> students = await DataBaseHelper().getStudent();
    setState(() {
      _students = students;
    });
  }

  _addStudent() async {
    setState(() async {
      if (_formKey.currentState!.validate()) {
        Student student = Student(
            id: int.parse(_idController.text),
            name: _nameController.text,
            age: int.parse(_ageController.text),
            section: _sectionController.text);
        await DataBaseHelper().insertStudent(student);
        _loadStudent();
        _idController.clear();
        _nameController.clear();
        _ageController.clear();
        _sectionController.clear();
      }
    });
  }

  _editStudent(Student student) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Student Details'),
          content: Form(
            child: Column(
              children: [
                // TextFormField(
                //   initialValue: student.id.toString(),
                //   decoration: const InputDecoration(labelText: 'ID'),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please Enter the ID';
                //     }
                //     return null;
                //   },
                // ),
                Text('ID : ${student.id}'),
                TextFormField(
                  initialValue: student.name,
                  decoration: const InputDecoration(labelText: 'NAme'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter the Name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: student.age.toString(),
                  decoration: const InputDecoration(labelText: 'Age'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter the Age';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: student.section,
                  decoration: const InputDecoration(labelText: 'Section'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter the Section';
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  //student.id = int.parse(_idController.text);
                  student.name = _nameController.text;
                  student.age = int.parse(_ageController.text);
                  student.section = _sectionController.text;
                  await DataBaseHelper().updateStudent(student);
                  _loadStudent();
                  Navigator.pop(context);
                },
                child: const Text('Save'))
          ],
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'ID'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter the ID';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter the Name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter the Age';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _sectionController,
              decoration: const InputDecoration(labelText: 'Section'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter the Section';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _addStudent,
              child: const Text('Add Student'),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _students.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_students[index].id.toString()),
                      subtitle: Column(
                        children: [
                          Text('Name : ${_students[index].name}'),
                          Text('Age : ${_students[index].age}'),
                          Text('Section : ${_students[index].section}')
                        ],
                      ),
                      trailing: ElevatedButton(
                          onPressed: () {
                            _editStudent(_students[index]);
                          },
                          child: const Text('Edit Student Detail')),
                    );
                  }),
            )
          ],
        ));
  }
}
