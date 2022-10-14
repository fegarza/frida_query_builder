import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';

class Equals extends CriterionCompare {
  Equals(
    String firstField,
    String secondField,
  ) : super(
          firstField,
          secondField,
          "=",
        );
}
