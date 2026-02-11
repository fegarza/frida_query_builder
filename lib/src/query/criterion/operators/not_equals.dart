import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';

class NotEquals extends CriterionCompare {
  NotEquals(
    Object? firstField,
    Object? secondField, {
    bool firstFieldQuoted = true,
    bool secondFieldQuoted = true,
  }) : super(
          firstField,
          secondField,
          "<>",
          firstFieldQuoted: firstFieldQuoted,
          secondFieldQuoted: secondFieldQuoted,
        );
}
