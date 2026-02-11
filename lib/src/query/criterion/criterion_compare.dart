import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';
import 'package:frida_query_builder/src/query/criterion/field.dart';

abstract class CriterionCompare extends Criterion {
  Object? firstField;
  Object? secondField;

  CriterionCompare(
    this.firstField,
    this.secondField,
    String compareOperator, {
    bool firstFieldQuoted = true,
    bool? secondFieldQuoted,
  }) : super(
          compareOperator,
          firstFieldQuoted: firstFieldQuoted,
          secondFieldQuoted: secondFieldQuoted ?? !(secondField is Field),
        );

  @override
  T accept<T>(StatementVisitor<T> visitor) =>
      visitor.visitCriterionCompare(this);
}
