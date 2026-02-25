import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Create Query Tests', () {
    test('Create simple table with Integer PK', () {
      final query = Create(
        tableName: 'users',
        columns: [
          ColumnInteger(
            name: 'id',
            isPrimaryKey: true,
            isAutoIncrement: true,
          ),
          ColumnText(name: 'username'),
        ],
      );

      expect(
        query.build(),
        equals(
          'CREATE TABLE users(\n'
          ' id INTEGER PRIMARY KEY AUTOINCREMENT,\n'
          ' username TEXT\n'
          ');',
        ),
      );
    });

    test('Create table with multiple column types and constraints', () {
      final query = Create(
        tableName: 'products',
        columns: [
          ColumnInteger(name: 'id', isPrimaryKey: true, isAutoIncrement: true),
          ColumnText(name: 'name', isNotNull: true, isUnique: true),
          ColumnReal(name: 'price', defaultValue: 0.00),
          ColumnBlob(name: 'image'),
        ],
      );

      final sql = query.build();
      expect(sql, contains('CREATE TABLE products'));
      expect(sql, contains('id INTEGER PRIMARY KEY AUTOINCREMENT'));
      expect(sql, contains('name TEXT NOT NULL UNIQUE'));
      expect(sql, contains("price REAL DEFAULT('0.00')"));
      expect(sql, contains('image BLOB'));
    });

    test('Create table with Foreign Key', () {
      final query = Create(
        tableName: 'orders',
        columns: [
          ColumnInteger(name: 'id', isPrimaryKey: true, isAutoIncrement: true),
          ColumnInteger(
            name: 'user_id',
            foreignKey: ForeignKey(
              referencedTable: 'users',
              referencedColumn: 'id',
            ),
          ),
        ],
      );

      final sql = query.build();
      expect(sql, contains('FOREIGN KEY(user_id) REFERENCES users(id)'));
    });

    test('Create table with Foreign Key Actions', () {
      final query = Create(
        tableName: 'orders',
        columns: [
          ColumnInteger(name: 'id', isPrimaryKey: true, isAutoIncrement: true),
          ColumnInteger(
            name: 'user_id',
            foreignKey: ForeignKey(
              referencedTable: 'users',
              referencedColumn: 'id',
              onDelete: ForeignKeyAction.cascade,
              onUpdate: ForeignKeyAction.setNull,
            ),
          ),
        ],
      );

      final sql = query.build();
      expect(
        sql,
        contains(
          'FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE SET NULL',
        ),
      );
    });

    test('Create table without Primary Key', () {
      final query = Create(
        tableName: 'no_pk',
        columns: [
          ColumnText(name: 'description'),
        ],
      );

      final sql = query.build();
      expect(sql, isNot(contains('PRIMARY KEY')));
    });

    test('Create table with composite Primary Key', () {
      final query = Create(
        tableName: 'composite_pk',
        columns: [
          ColumnInteger(name: 'id1', isPrimaryKey: true),
          ColumnInteger(name: 'id2', isPrimaryKey: true),
        ],
      );

      final sql = query.build();
      expect(sql, contains('PRIMARY KEY(id1, id2)'));
    });

    test('Create table with IF NOT EXISTS', () {
      final query = Create(
        tableName: 'users',
        columns: [
          ColumnInteger(name: 'id', isPrimaryKey: true),
        ],
      ).ifNotExists();

      expect(
        query.build(),
        startsWith('CREATE TABLE IF NOT EXISTS users(\n'),
      );
    });
    test('Create table with text default value and escaping', () {
      final query = Create(
        tableName: 'settings',
        columns: [
          ColumnText(name: 'key', isPrimaryKey: true),
          ColumnText(name: 'value', defaultValue: "It's a value"),
          ColumnText(name: 'email', defaultValue: 'example@outlook.com'),
        ],
      );

      final sql = query.build();
      expect(sql, contains("value TEXT DEFAULT('It''s a value')"));
      expect(sql, contains("email TEXT DEFAULT('example@outlook.com')"));
    });
  });
}
