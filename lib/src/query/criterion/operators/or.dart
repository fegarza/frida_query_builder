import 'package:frida_query_builder/src/query/criterion/criterion.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_logic.dart';

class Or extends CriterionLogic {
  Or(List<Criterion> criteria) : super(criteria, "OR");
}
