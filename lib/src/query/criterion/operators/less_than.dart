import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';

class LessThan extends CriterionCompare {
  LessThan(
    Object? firstField,
    Object? secondField,
  ) : super(
          firstField,
          secondField,
          "<",
        );
}
