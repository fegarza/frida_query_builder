import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';

class In extends CriterionCompare {
  In(String firstField, List<String> inFields)
      : super(firstField, "( " + inFields.join(" , ") + " )", "IN");
}
