import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/common/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/common/sql_renderer.dart';

class CriteriaQueryBuilder extends FridaQueryBuilder {
  CriteriaStatement criteriaStatement;
  CriteriaQueryBuilder(this.criteriaStatement) : super(criteriaStatement);

  @override
  String build() {
    return criteriaStatement.accept(SqlRenderer());
  }
}
