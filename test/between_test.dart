import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Between Operator Tests', () {
    test('Between operator validation', () {
      final query = Select(
        from: 'users',
        where: [
          Between('age'.field, 18, 30),
        ],
      );
      final sql = query.build();
      expect(sql, contains('WHERE age BETWEEN 18 AND 30'));
    });

    test('Between operator with date strings', () {
      final query = Select(
        from: 'events',
        where: [
          Between('event_date'.field, '2023-01-01', '2023-12-31'),
        ],
      );
      final sql = query.build();
      // Strings should be quoted by FieldQueryBuilder when passed to Between
      expect(sql,
          contains("WHERE event_date BETWEEN '2023-01-01' AND '2023-12-31'"));
    });

    test('Between operator with mixed types', () {
      final query = Select(
        from: 'products',
        where: [
          Between('price'.field, 10.5, 20),
        ],
      );
      final sql = query.build();
      expect(sql, contains('WHERE price BETWEEN 10.5 AND 20'));
    });
  });
}
