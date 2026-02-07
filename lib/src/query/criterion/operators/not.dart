import 'package:frida_query_builder/frida_query_builder.dart';

class Not extends CriterionLogic {
  Not(List<Criterion> criteria) : super(criteria, "NOT");
}
