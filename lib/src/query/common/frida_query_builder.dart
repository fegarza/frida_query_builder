import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/common/sql_renderer.dart';
import 'package:frida_query_builder/src/query/common/statement.dart';

/// Main entry point for the query builder.
///
/// Wraps a [Statement] and provides a [build] method to generate SQL.
class FridaQueryBuilder implements QueryBuilder {
  /// The statement to be built.
  Statement statement;

  FridaQueryBuilder(this.statement);

  /// Builds the SQL string for the wrapped [statement].
  @override
  String build() {
    return statement.accept(SqlRenderer());
  }
}
