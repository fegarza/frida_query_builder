import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/sql_renderer.dart';

/// Extension to provide a convenient [build] method on any [Statement].
extension FridaStatementExtension on Statement {
  /// Builds the SQL string for this statement using the default [SqlRenderer].
  String build() {
    return accept(SqlRenderer());
  }
}
