import 'package:frida_query_builder/src/query/criterion/criterion.dart';

abstract class CriterionCompare extends Criterion {
  String firstField;
  String secondField;

  CriterionCompare(this.firstField, this.secondField, String compareOperator)
      : super(compareOperator);
}
