import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';

abstract class CriterionCompare extends Criterion {
  Object? firstField;
  Object? secondField;

  CriterionCompare(
    this.firstField,
    this.secondField,
    String compareOperator, {
    firstFieldQuoted = true,
    secondFieldQuoted = true,
  }) : super(
          compareOperator,
          firstFieldQuoted: firstFieldQuoted,
          secondFieldQuoted: secondFieldQuoted,
        );

  @override
  T accept<T>(StatementVisitor<T> visitor) =>
      visitor.visitCriterionCompare(this);
}
