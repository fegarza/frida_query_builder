import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';

class GreaterThan extends CriterionCompare {
  GreaterThan(
    Object? firstField,
    Object? secondField,
  ) : super(
          firstField,
          secondField,
          ">",
        );
}
