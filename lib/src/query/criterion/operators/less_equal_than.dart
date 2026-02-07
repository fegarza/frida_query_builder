import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';

class LessEqualThan extends CriterionCompare {
  LessEqualThan(
    Object? firstField,
    Object? secondField,
  ) : super(
          firstField,
          secondField,
          "<=",
        );
}
