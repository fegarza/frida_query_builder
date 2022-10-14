import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';

class Like extends CriterionCompare {
  Like(String firstField, String secondField)
      : super(firstField, secondField, "LIKE");
}
