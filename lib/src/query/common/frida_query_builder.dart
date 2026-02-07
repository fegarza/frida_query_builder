import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/common/sql_renderer.dart';
import 'package:frida_query_builder/src/query/common/statement.dart';

class FridaQueryBuilder implements QueryBuilder {
  Statement statement;

  FridaQueryBuilder(this.statement);

  @override
  String build() {
    return statement.accept(SqlRenderer());
  }
}
