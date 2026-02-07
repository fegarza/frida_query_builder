import 'package:frida_query_builder/src/query/criterion/criterion.dart';

abstract class CriterionLogic extends Criterion {
  List<Criterion> criteria;

  CriterionLogic(
    this.criteria,
    String criterionOperator,
  ) : super(criterionOperator);
}
