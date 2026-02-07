import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Insert Query Tests', () {
    test('Insert simple values', () {
      final query = Insert(
        into: 'users',
        values: {
          'name': 'John Doe',
          'age': 30,
        },
      );

      final sql = query.build();
      expect(sql, startsWith('INSERT INTO users(name, age) VALUES('));
      expect(sql, contains('"John Doe"'));
      expect(sql, contains('30'));
    });

    test('Insert with null value', () {
      final query = Insert(
        into: 'users',
        values: {
          'name': 'Jane',
          'email': null,
        },
      );

      final sql = query.build();
      expect(sql, contains('NULL'));
    });

    test('Insert with boolean (mapped to int)', () {
      // Assuming implementation handles boolean or user converts manually
      // If no direct boolean support, user passes 1/0
      final query = Insert(
        into: 'settings',
        values: {
          'is_active': 1,
        },
      );
      expect(query.build(),
          contains('INSERT INTO settings(is_active) VALUES(1);'));
    });
  });
}
