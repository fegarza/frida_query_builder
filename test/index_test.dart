import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Index Query Tests', () {
    test('Create simple index', () {
      final query = CreateIndex(
        indexName: 'idx_user_name',
        on: 'users',
        columns: ['name'],
      );
      expect(
          query.build(), equals('CREATE INDEX idx_user_name ON users (name);'));
    });

    test('Create unique index', () {
      final query = CreateIndex(
        indexName: 'idx_user_email',
        on: 'users',
        columns: ['email'],
        unique: true,
      );
      expect(
        query.build(),
        equals('CREATE UNIQUE INDEX idx_user_email ON users (email);'),
      );
    });

    test('Create multi-column index', () {
      final query = CreateIndex(
        indexName: 'idx_user_first_last',
        on: 'users',
        columns: ['first_name', 'last_name'],
      );
      expect(
        query.build(),
        equals(
            'CREATE INDEX idx_user_first_last ON users (first_name, last_name);'),
      );
    });

    test('Drop index', () {
      final query = DropIndex('idx_user_name');
      expect(query.build(), equals('DROP INDEX idx_user_name;'));
    });
  });
}
