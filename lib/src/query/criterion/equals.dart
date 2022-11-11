import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';

class Equals extends CriterionCompare {
  Equals(
    Object? firstField,
    Object? secondField,
  ) : super(
          firstField,
          secondField,
          "=",
        );
}
