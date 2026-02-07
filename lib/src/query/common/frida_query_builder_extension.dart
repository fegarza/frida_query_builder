import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/sql_renderer.dart';

extension FridaStatementExtension on Statement {
  String build() {
    return accept(SqlRenderer());
  }
}
