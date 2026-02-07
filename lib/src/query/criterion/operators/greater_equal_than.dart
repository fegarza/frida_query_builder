import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';

class GreaterEqualThan extends CriterionCompare {
  GreaterEqualThan(
    Object? firstField,
    Object? secondField,
  ) : super(
          firstField,
          secondField,
          ">=",
        );
}
