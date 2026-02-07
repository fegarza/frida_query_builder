import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/common/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_compare_query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_login.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_logic_query_builder.dart';
import 'package:frida_query_builder/src/query/delete/delete.dart';
import 'package:frida_query_builder/src/query/delete/delete_query_builder.dart';
import 'package:frida_query_builder/src/query/select/select.dart';
import 'package:frida_query_builder/src/query/select/select_query_builder.dart';
import 'package:frida_query_builder/src/query/update/update.dart';
import 'package:frida_query_builder/src/query/update/update_query_builder.dart';

class CriteriaQueryBuilder extends FridaQueryBuilder {
  CriteriaStatement criteriaStatement;
  CriteriaQueryBuilder(this.criteriaStatement) : super(criteriaStatement);

  @override
  String build() {
    switch (statement.runtimeType) {
      case Select:
        return SelectQueryBuilder(statement as Select).build();
      case Update:
        return UpdateQueryBuilder(statement as Update).build();
      case Delete:
        return DeleteQueryBuilder(statement as Delete).build();
      default:
        return _buildCriteriaString();
    }
  }

  String _buildCriteriaString() {
    var sb = StringBuffer();

    bool isFirstIteration = true;
    for (final criteria in criteriaStatement.criteria) {
      if (criteria is CriterionLogic) {
        sb.write(
          CriterionLogicQueryBuilder(criteria,
                  quoted: criteria.firstFieldQuoted)
              .build(),
        );
      }

      if (criteria is CriterionCompare) {
        if (!isFirstIteration) {
          sb.write(" AND ");
        }
        sb.write(
          CriterionCompareQueryBuilder(
            criteria,
            firstFieldQuoted: criteria.firstFieldQuoted,
            secondFieldQuoted: criteria.secondFieldQuoted,
          ).build(),
        );
      }

      isFirstIteration = false;
    }

    return sb.toString();
  }
}
