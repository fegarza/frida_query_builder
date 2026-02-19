import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Select Optional FROM Tests', () {
    test('Select without FROM clause', () {
      final query = Select(
        columns: ['1'.field.as('one')],
      );
      final sql = query.build();
      expect(sql, equals('SELECT 1 AS one;'));
    });

    test('Select with simple calculation', () {
      // Assuming we can pass raw strings or fields.
      // If we use '1 + 1'.field, it might be quoted as identifier depending on Field implem.
      // Use '1'.field for now.
      final query = Select(
        columns: ['1'.field],
      );
      expect(query.build(), equals('SELECT 1;'));
    });
  });
}
