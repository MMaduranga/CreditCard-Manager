// import 'package:sqflite/sqflite.dart';
// import 'package:flutter/material.dart';
//
// class DataBaseConnection{
//   static final DataBaseConnection instance=DataBaseConnection._init();
//   static Database? _database;
//   DataBaseConnection._init();
//   Future<Database> get databse async{
//     if (_database!=null) return _database!; //check whether the database exits
//     _database =await _initDB("notes.db");
//     return _database!;
//   }
//   Future<Database> _initDB(String filePath) async{
//     final dbPath=await getDatabasesPath();
//     final path= join(dbPath,filePath);
//     return await openDatabase(path,version: 1,onCreate:_createDB );
//   }
//   Future _createDB(Database db,int version) async{
//
//   }
//   Future close()async{
//     final db=await instance.databse;
//     db.close();
//   }
// }