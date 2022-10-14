import 'package:frida_query_builder/src/query/criterion/criterion.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_logic.dart';

class And extends CriterionLogic {
  And(List<Criterion> criteria) : super(criteria, "AND");
}
