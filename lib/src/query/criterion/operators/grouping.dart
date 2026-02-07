import 'package:frida_query_builder/src/query/criterion/criterion.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_login.dart';

class Grouping extends CriterionLogic {
  Grouping(List<Criterion> criteria, String criterionOperator)
      : super(criteria, criterionOperator);
}
