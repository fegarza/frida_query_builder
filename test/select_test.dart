import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Select Query Tests', () {
    test('Select all columns', () {
      final query = Select(from: 'users');
      expect(query.build(), equals('SELECT *\nFROM users;'));
    });

    test('Select specific columns', () {
      final query = Select(
        from: 'users',
        columns: ['id'.field, 'name'.field],
      );
      expect(query.build(), equals('SELECT id, name\nFROM users;'));
    });

    test('Select DISTINCT', () {
      final query =
          Select(from: 'users', columns: ['name'.field], distinct: true);
      expect(query.build(), startsWith('SELECT DISTINCT name'));
    });

    test('Select with WHERE clause', () {
      final query = Select(
        from: 'users',
        where: [
          Equals('id'.field, 1),
          GreaterThan('age'.field, 18),
        ],
      );
      final sql = query.build();
      expect(sql, contains('WHERE id = 1 AND age > 18'));
    });

    test('Select with JOIN', () {
      final query = Select(
        from: 'orders',
        joins: [
          Join(
            'users',
            type: JoinType.inner,
            criteria: [Equals('orders.user_id'.field, 'users.id'.field)],
          )
        ],
      );
      final sql = query.build();
      expect(sql, contains('INNER JOIN users\n ON orders.user_id = users.id'));
    });

    test('Select with GROUP BY and HAVING', () {
      final query = Select(
        from: 'orders',
        columns: ['user_id'.field, Count('id').as('order_count')],
        groupBy: ['user_id'],
        having: [GreaterThan(Count('id'), 5)],
      );
      final sql = query.build();
      expect(sql, contains('GROUP BY user_id'));
      expect(sql, contains('HAVING COUNT(id) > 5'));
      expect(sql, contains('COUNT(id) AS order_count'));
    });

    test('Select with Sum and alias', () {
      final query = Select(
        from: 'orders',
        columns: [Sum('amount').as('total_amount')],
      );
      final sql = query.build();
      expect(sql, contains('SUM(amount) AS total_amount'));
    });

    test('Select with ORDER BY, LIMIT and OFFSET', () {
      final query = Select(
        from: 'users',
        orderBy: ['created_at DESC'],
        limit: 10,
        offset: 5,
      );
      final sql = query.build();
      expect(sql, contains('ORDER BY created_at DESC'));
      expect(sql, contains('LIMIT 10 OFFSET 5'));
    });
  });
}
