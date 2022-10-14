import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';

class NotEquals extends CriterionCompare {
  NotEquals(
    String firstField,
    String secondField,
  ) : super(
          firstField,
          secondField,
          "<>",
        );
}
