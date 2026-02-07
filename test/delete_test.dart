import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Delete Query Tests', () {
    test('Delete all rows', () {
      final query = Delete(table: 'temp_logs');
      expect(query.build(), equals('DELETE FROM temp_logs;'));
    });

    test('Delete with WHERE clause', () {
      final query = Delete(
        table: 'users',
        criteria: [Equals('id'.field, 100)],
      );
      final sql = query.build();
      expect(sql, startsWith('DELETE FROM users\n'));
      expect(sql, contains('WHERE id = 100 ;'));
    });

    test('Delete with complex criteria', () {
      final query = Delete(table: 'logs', criteria: [
        LessThan('created_at'.field, '2023-01-01'),
        Or([Equals('status'.field, "archived")])
      ]);
      // Note: Logic operators might vary in output format depending on implementation detail of CriteriaQueryBuilder
      // Adjust expectation based on actual output format if needed.
      final sql = query.build();
      expect(sql, contains('created_at < "2023-01-01"'));
      expect(sql, contains('OR( status = "archived" )'));
    });
  });
}
