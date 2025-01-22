import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';

class Student {
  int? id;
  String? name;
  int? age;
  String? section;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.section,
  });

  Map<String, dynamic> toMap() {
    return {
      'id ': id,
      'name': name,
      'age': age,
      'section': section,
    };
  }
}

class DataBaseHelper {
  static Database? _database;

  Future<Database?> get dataBase async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'student_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE  student(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, section TEXT)');
      },
      version: 1,
    );
  }

  Future<int> insertStudent(Student student) async {
    Database? db = await dataBase;
    return await db!.insert("student", student.toMap());
  }

  Future<List<Student>> getStudent() async {
    Database? db = await dataBase;
    List<Map<String, dynamic>> maps = await db!.query('student');
    return List.generate(maps.length, (i) {
      return Student(
          id: maps[i]['id'],
          name: maps[i]['name'],
          age: maps[i]['age'],
          section: maps[i]['section']);
    });
  }

  Future<int> updateStudent(Student student) async {
    Database? db = await dataBase;
    return await db!.update(
      'student',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }
  Future<int > deleteStudent (int id ) async {
    Database? db = await dataBase;
    return db!.delete('student',where: 'id = ? ', whereArgs: [id]);
  }
}
