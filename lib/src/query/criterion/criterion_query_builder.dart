import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';

class CriterionQueryBuilder implements QueryBuilder {
  Criterion criterion;

  CriterionQueryBuilder(this.criterion);

  
  
  
  String build() {

    return "";
    /*var sb = StringBuffer();

    if (criterion is CriterionLogicOperator) {
      var logicCriterion = (criterion as CriterionLogicOperator);

      if (logicCriterion.criteria.isEmpty) {
        return "";
      }

      sb.write(" ${logicCriterion.logic_operator} ( ");

      bool isFirstElemet = true;

      logicCriterion.criteria.forEach(
        (element) {
          sb.write(
            CriterionBuilder(element, !isFirstElemet).build(),
          );
          isFirstElemet = false;
        },
      );

      sb.write(" ) ");
    }

    if (criterion is CriterionOperation) {
      var criterionOperation = (criterion as CriterionOperation);
      if (this.includeAndOperator) {
        sb.write(" AND ");
      }
      sb.write(
          " ${criterionOperation.first_field} ${criterionOperation.criterion_operator} ${criterionOperation.second_field} ");
    }

    return sb.toString();*/
  }

 
}
