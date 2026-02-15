import 'package:frida_query_builder/src/query/common/sql_renderer.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_logic.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_query_builder.dart';

class CriterionLogicQueryBuilder extends CriterionQueryBuilder {
  CriterionLogic criterionLogic;
  final bool quoted;

  CriterionLogicQueryBuilder(
    this.criterionLogic, {
    this.quoted = true,
  }) : super(criterionLogic);

  @override
  String build() {
    return criterionLogic.accept(SqlRenderer());
  }
}
