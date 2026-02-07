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
      expect(sql, contains('price REAL DEFAULT(0.00)'));
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
  });
}
