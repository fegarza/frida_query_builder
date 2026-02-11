import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/criterion/criteria_query_builder.dart';
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
    var sb = StringBuffer();

    if (criterionLogic.criteria.isEmpty) {
      return "";
    }

    sb.write(" ${criterionLogic.criterionOperator}(");

    sb.write(
      CriteriaQueryBuilder(
        CriteriaStatement("", criteria: criterionLogic.criteria),
      ).build(),
    );

    sb.write(") ");

    return sb.toString();
  }
}
