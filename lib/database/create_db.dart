import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class db_get {
  static Future<Database> create_db() async {
    final Future<Database> database = openDatabase(
        // Set the path to the database.
        join(await getDatabasesPath(), 'doggie_database.db'),
        // When the database is first created, create a table to store dogs.
        onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      db.execute(
        """
     CREATE TABLE imagup
  (
       id INT, 
       plan TEXT, 
       user TEXT,
       img TEXT,
       lat REAL,
       lon REAL,
       city TEXT,
       district TEXT, 
       village TEXT,
       date TEXT,
       dayCount TEXT,
       dogCount TEXT,
       repeatCount TEXT,
       update_data INT,
       primary key (id, plan,user)
    );
    """,
      );
      db.execute("""
      CREATE TABLE USERE 
	    (
       plan TEXT, 
       user TEXT,
       name TEXT,
       id INT,
       date TEXT,
       primary key ( plan,user)
        );""");
      db.execute("""CREATE TABLE timingLocation 
	(
       plan TEXT, 
       user TEXT,
       time TEXT,
       lat REAL,
       lon REAL,
       primary key (plan,user,time)
    );""");
    }, version: 1
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        );
    return database;
  }
}
