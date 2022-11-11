import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';

class Like extends CriterionCompare {
  Like(Object? firstField, Object? secondField)
      : super(firstField, secondField, "LIKE");
}
