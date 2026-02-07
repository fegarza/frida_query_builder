import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Alter Query Tests', () {
    test('Rename table', () {
      final query = RenameTable('old_users', 'new_users');
      expect(
        query.build(),
        equals('ALTER TABLE old_users RENAME TO new_users;'),
      );
    });

    test('Add column', () {
      final query = AddColumn(
        'users',
        ColumnText(name: 'email', isNotNull: true),
      );
      expect(
        query.build(),
        equals('ALTER TABLE users ADD COLUMN email TEXT NOT NULL;'),
      );
    });

    test('Rename column', () {
      final query = RenameColumn('users', 'old_col', 'new_col');
      expect(
        query.build(),
        equals('ALTER TABLE users RENAME COLUMN old_col TO new_col;'),
      );
    });

    test('Drop column', () {
      final query = DropColumn('users', 'obsolete_col');
      expect(
        query.build(),
        equals('ALTER TABLE users DROP COLUMN obsolete_col;'),
      );
    });

    test('Drop table', () {
      final query = DropTable('users');
      expect(
        query.build(),
        equals('DROP TABLE users;'),
      );
    });
  });
}
