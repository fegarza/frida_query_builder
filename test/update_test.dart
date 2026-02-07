import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Update Query Tests', () {
    test('Update all rows', () {
      final query = Update(
        table: 'users',
        values: {'status': 'active'},
      );
      expect(query.build(), equals('UPDATE users SET status = "active" ;'));
    });

    test('Update with WHERE clause', () {
      final query = Update(
        table: 'users',
        values: {'status': 'inactive'},
        criteria: [Equals('id'.field, 1)],
      );

      final sql = query.build();
      expect(sql, startsWith('UPDATE users SET status = "inactive"'));
      expect(sql, contains('WHERE id = 1 ;'));
    });

    test('Update multiple columns', () {
      final query = Update(
          table: 'products',
          values: {'price': 19.99, 'stock': 100},
          criteria: [Equals('id'.field, 5)]);

      final sql = query.build();
      expect(sql, contains('price = 19.99'));
      expect(sql, contains('stock = 100'));
    });
  });
}
